extends Area2D

onready var cooldown_timer = $Cooldown
onready var clock = $Clock

onready var dull_sprite = $Sprite2

var player = null

var on_cooldown = false

func _on_Bush_body_entered(body):
	if body.is_in_group("player"):
		player = body


func _on_Bush_body_exited(body):
	if body.is_in_group("player"):
		player = null


func start_cooldown():
	AudioManager.play(load("res://assets/sounds/bush/01_bush_rustling_2.wav"), "SFX", 0)
	on_cooldown = true
	cooldown_timer.start()
	dull_sprite.visible = true
	clock.visible = true


func _on_Cooldown_timeout():
	on_cooldown = false
	dull_sprite.visible = false
	clock.visible = false
