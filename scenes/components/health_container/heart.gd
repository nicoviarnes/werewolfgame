extends TextureRect

onready var tween = $Tween

onready var initial_scale = rect_scale

var scale_up = true

# Called when the node enters the scene tree for the first time.
func _ready():
	scale_tween()


func scale_tween():
	if scale_up:
		tween.interpolate_property(self, "rect_scale", initial_scale, initial_scale * 1.1, 1.5)
		scale_up = false
		tween.start()
	else:
		tween.interpolate_property(self, "rect_scale", rect_scale, initial_scale, 1.5)
		scale_up = true
		tween.start()


func _on_Tween_tween_all_completed():
	scale_tween()
