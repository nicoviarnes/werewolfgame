extends KinematicBody2D

onready var tween = $Tween
onready var anim = $AnimationPlayer
onready var human_sprite = $HumanSprite
onready var wolf_sprite = $WolfSprite
onready var player_light = $PlayerLight

export var speed = 75
export var friction = 0.1
export var acceleration = 0.1

var velocity = Vector2()

onready var current_sprite = human_sprite
onready var old_sprite = wolf_sprite

var current_form = "human"

func get_input():
	var input = Vector2()
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
	return input


func _physics_process(_delta):
	var direction = get_input()
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
			old_sprite = wolf_sprite
			current_sprite = human_sprite
			current_sprite.visible = true
			old_sprite.visible = false
		"wolf":
			speed = 150
			old_sprite = human_sprite
			current_sprite = wolf_sprite
			current_sprite.visible = true
			old_sprite.visible = false
