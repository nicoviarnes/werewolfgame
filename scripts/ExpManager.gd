extends Node


signal update_exp_bar

var xp = 0

var level = 1

var levelup_xp = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_exp(i):
	xp += i
	if xp >= levelup_xp:
		AudioManager.play(load("res://assets/sounds/player/03_Holy_Aura.wav"), "SFX", 0)
		level += 1
		levelup_xp *= 1.6
		xp = 0

	emit_signal("update_exp_bar", i)
