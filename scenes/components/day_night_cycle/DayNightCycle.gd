extends Node2D

signal day
signal night

onready var day_timer = $DayTimer
onready var night_timer = $NightTimer
onready var anim = $AnimationPlayer

func _ready():
	day_timer.start()
	var lights = get_tree().get_nodes_in_group("light")
	for light in lights:
		self.connect("day", light, "_on_day")
		self.connect("night", light, "_on_night")

	var buildings = get_tree().get_nodes_in_group("building")
	for building in buildings:
		self.connect("day", building, "_on_day")
		self.connect("night", building, "_on_night")	

func _on_DayTimer_timeout():
	anim.play("sunset")
	night_timer.start()
	emit_signal("night")
	CycleManager.daytime = false


func _on_NightTimer_timeout():
	anim.play("sunrise")
	day_timer.start()
	emit_signal("day")
	CycleManager.daytime = true
