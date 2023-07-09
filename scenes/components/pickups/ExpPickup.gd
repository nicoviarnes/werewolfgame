extends Area2D

onready var anim = $AnimationPlayer
onready var tween = $Tween
onready var sprite = $Sprite

var initial_scale = Vector2(.25, .25)
var target_scale = Vector2(.3, .3)

var scale_up = true

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play(load("res://assets/sounds/pickups/pickup_spawn.wav"), "SFX", 0)
	anim.play("orb")
	scale_tween()


func _on_ExpPickup_body_entered(body):
	if body.is_in_group("player"):
		handle_pickup()


func handle_pickup():
	AudioManager.play(load("res://assets/sounds/pickups/pickup_grabbed.wav"), "SFX", 0)
	ExpManager.update_exp(50)
	queue_free()


func scale_tween():
	if scale_up:
		tween.interpolate_property(sprite, "scale", sprite.scale, target_scale, 1.5)
		scale_up = false
		tween.start()
	else:
		tween.interpolate_property(sprite, "scale", target_scale, initial_scale, 1.5)
		scale_up = true
		tween.start()


func _on_Tween_tween_all_completed():
	scale_tween()
