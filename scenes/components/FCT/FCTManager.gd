extends Node2D

var FCT = preload("res://scenes/components/FCT/FCT.tscn")

export var travel = Vector2(0, -80)
export var duration = 2
export var spread = PI/2

func show_value(node, value, points=false, xp=false):
	var fct = FCT.instance()
	#fct.global_position = global_position
	if node != null:
		fct.rect_position = node
	add_child(fct)
	fct.show_value(str(value), travel, duration, spread, points, xp)
