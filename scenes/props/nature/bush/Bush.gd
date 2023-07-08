extends Area2D

onready var cooldown_timer = $Cooldown

var player = null

var on_cooldown = false

func _on_Bush_body_entered(body):
	if body.is_in_group("player"):
		player = body


func _on_Bush_body_exited(body):
	if body.is_in_group("player"):
		player = null


func start_cooldown():
	on_cooldown = true
	cooldown_timer.start()


func _on_Cooldown_timeout():
	on_cooldown = false
