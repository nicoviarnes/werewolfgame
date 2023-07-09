extends Node2D

signal day
signal night

onready var day_timer = $DayTimer
onready var night_timer = $NightTimer
onready var anim = $AnimationPlayer
var current_timer

func _ready():
	current_timer = day_timer
	day_timer.start()
	var lights = get_tree().get_nodes_in_group("light")
	for light in lights:
		self.connect("day", light, "_on_day")
		self.connect("night", light, "_on_night")

	var buildings = get_tree().get_nodes_in_group("building")
	for building in buildings:
		self.connect("day", building, "_on_day")
		self.connect("night", building, "_on_night")	


func _process(delta):
	CycleManager.update_timer(current_timer)

func _on_DayTimer_timeout():
	current_timer = night_timer
	anim.play("sunset")
	night_timer.start()
	emit_signal("night")
	CycleManager.update_day()


func _on_NightTimer_timeout():
	current_timer = day_timer
	anim.play("sunrise")
	day_timer.start()
	emit_signal("day")
	CycleManager.update_day()
