extends KinematicBody2D

onready var tween = $Tween
onready var anim = $AnimationPlayer
onready var human_sprite = $HumanSprite
onready var wolf_sprite = $WolfSprite
onready var player_light = $PlayerLight
onready var dash_timer = $DashTimer

export var speed = 75
export var friction = 0.1
export var acceleration = 0.1
var dash_speed = 300
var health = 100

var velocity = Vector2()

onready var current_sprite = human_sprite
onready var old_sprite = wolf_sprite

var current_form = "human"

var nearest_bush = null

var hiding = false

var dashing = false
var dash_cooldown = false

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
	match form:
		"human":
			speed = 50
			dash_speed = 150
			old_sprite = wolf_sprite
			current_sprite = human_sprite
			current_sprite.visible = true
			old_sprite.visible = false
		"wolf":
			if hiding:
				exit_bush()
			speed = 150
			dash_speed = 400
			old_sprite = human_sprite
			current_sprite = wolf_sprite
			current_sprite.visible = true
			old_sprite.visible = false


func dash(dir):
	if not dash_cooldown:
		dashing = true
		velocity = dir * dash_speed
		dashing = false
		dash_cooldown = true
		dash_timer.start()


func hide_in_bush():
	hiding = true
	global_position = nearest_bush.global_position
	global_position.y -= 5


func exit_bush():
	nearest_bush.start_cooldown()
	nearest_bush = null
	hiding = false


func take_damage():
	print("player take damage")


func _on_Detection_area_entered(area):
	if area.is_in_group("bush"):
		nearest_bush = area


func _on_Detection_area_exited(area):
	if area.is_in_group("bush"):
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
			var bump_direction = (global_position - area.global_position).normalized()
			velocity = bump_direction * 175
			take_damage()
