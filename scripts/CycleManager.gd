extends Node
signal day
signal night

var daytime = true
var max_time = 0.0
var time_left = 0.0

func update_timer(node):
	max_time = node.wait_time
	time_left = node.time_left

func update_day():
	if daytime:
		#AudioManager.play(load("res://assets/sounds/ambient/11_Crickets_2_loop.wav"), "SFX", 0)
		daytime = false
		emit_signal("night")
	else:
		daytime = true
		emit_signal("day")
