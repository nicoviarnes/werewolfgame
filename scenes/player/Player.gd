extends KinematicBody2D

signal hurt
signal health_pickup
signal dash
signal near_bush
signal in_bush

onready var camera = $Camera2D
onready var tween = $Tween
onready var anim = $AnimationPlayer
onready var human_sprite = $HumanSprite
onready var wolf_sprite = $WolfSprite
onready var player_light = $PlayerLight
onready var dash_timer = $DashTimer
onready var dash_speed = SkillManager.dash_length
onready var speed = SkillManager.human_speed

export var friction = 0.1
export var acceleration = 0.1


var velocity = Vector2()

onready var current_sprite = human_sprite
onready var old_sprite = wolf_sprite

var current_form = "human"

var nearest_bush = null

var hiding = false

var dashing = false
var dash_cooldown = false


func _ready():
	SkillManager.connect("update_stats", self, "_on_update_stats")

func get_input():
	var input = Vector2()
	
	if not dashing && not hiding:
		if Input.is_action_pressed('right'):
			current_sprite.flip_h = false
			input.x += 1
		if Input.is_action_pressed('left'):
			current_sprite.flip_h = true
			input.x -= 1
		if Input.is_action_pressed('down'):
			input.y += 1
		if Input.is_action_pressed('up'):
			input.y -= 1
		if Input.is_action_just_pressed("dash"):
			dash(input)
		if Input.is_action_just_pressed("hide") && nearest_bush != null && current_form == "human":
			hide_in_bush()
		
	elif hiding:
		if Input.is_action_just_pressed("hide") && hiding:
			exit_bush()
			
			
	return input


func _physics_process(_delta):
	var direction = get_input()
	if not dashing && not hiding:
		if direction.length() > 0:
			anim.play(current_form + "_walk")
			velocity = lerp(velocity, direction.normalized() * speed, acceleration)
		else:
			velocity = lerp(velocity, Vector2.ZERO, friction)
		velocity = move_and_slide(velocity)


func _on_day():
	shapeshift("human")
	tween.interpolate_property(player_light, "energy", player_light.energy, 0, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_all_completed")


func _on_night():
	shapeshift("wolf")
	tween.interpolate_property(player_light, "energy", player_light.energy, 0.5, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func shapeshift(form):
	current_form = form
	camera.apply_noise_shake()
	match form:
		"human":
			speed = SkillManager.human_speed
			dash_speed = SkillManager.dash_length
			old_sprite = wolf_sprite
			current_sprite = human_sprite
			current_sprite.visible = true
			old_sprite.visible = false
		"wolf":
			speed = SkillManager.wolf_speed
			dash_speed = SkillManager.dash_length
			AudioManager.play(load("res://assets/sounds/player/transform.wav"), "SFX", 0)
			if hiding:
				exit_bush()
			old_sprite = human_sprite
			current_sprite = wolf_sprite
			current_sprite.visible = true
			old_sprite.visible = false


func dash(dir):
	if not dash_cooldown:
		emit_signal("dash")
		AudioManager.play(load("res://assets/sounds/player/dash.wav"), "SFX", 0)
		dashing = true
		velocity = dir * dash_speed
		dashing = false
		dash_cooldown = true
		dash_timer.start()


func hide_in_bush():
	emit_signal("in_bush", true)
	AudioManager.play(load("res://assets/sounds/bush/01_bush_rustling_1.wav"), "SFX", 0)
	hiding = true
	global_position = nearest_bush.global_position
	global_position.y -= 5


func exit_bush():
	emit_signal("in_bush", false)
	emit_signal("near_bush", false)
	nearest_bush.start_cooldown()
	nearest_bush = null
	hiding = false


func take_damage():
	camera.apply_noise_shake()
	emit_signal("hurt")


func _on_Detection_area_entered(area):
	if area.is_in_group("bush"):
		if current_form != "wolf":
			emit_signal("near_bush", true)
		nearest_bush = area


func _on_Detection_area_exited(area):
	if area.is_in_group("bush"):
		if current_form != "wolf":
			emit_signal("near_bush", false)
		nearest_bush = null



func _on_DashTimer_timeout():
	dash_cooldown = false


func _on_Hitbox_area_entered(area):
	if area.is_in_group("enemy_hurtbox"):
		if current_form == "wolf":
			area.get_parent().take_damage()


func _on_Hurtbox_area_entered(area):
	if area.is_in_group("enemy_hitbox"):
		if current_form == "human":
			if not hiding:
				var bump_direction = (global_position - area.global_position).normalized()
				velocity = bump_direction * 250
				take_damage()


func _on_update_stats():
	dash_speed = SkillManager.dash_length
	if current_form == "human":
		speed = SkillManager.human_speed
	else:
		speed = SkillManager.wolf_speed
