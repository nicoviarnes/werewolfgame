extends TextureRect

signal warning

onready var progress_bar = $TextureProgress

onready var night_texture = load("res://assets/UI/progress_bar/Night_Timer_Empty_01.png")
onready var day_texture = load("res://assets/UI/progress_bar/Day_Timer_Empty_01.png")

var day = true

func _ready():
	CycleManager.connect("day", self, "_on_day")
	CycleManager.connect("night", self, "_on_night")

func _process(delta):
	progress_bar.max_value = CycleManager.max_time
	progress_bar.value = CycleManager.time_left
	if CycleManager.time_left < 11 && CycleManager.time_left > 10:
		emit_signal("warning", day)

func _on_day():
	texture = day_texture
	day = true

func _on_night():
	texture = night_texture
	day = false
