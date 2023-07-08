extends StaticBody2D

onready var anim = $AnimationPlayer
onready var sprite = $Sprite

onready var light1 = $Light2D
onready var light2 = $Light2D2
onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = 2


func _on_day():
	tween.interpolate_property(light1, "energy", light1.energy, 0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(light2, "energy", light2.energy, 0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	anim.play_backwards("on")

func _on_night():
	tween.interpolate_property(light1, "energy", light1.energy, 0.3, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(light2, "energy", light2.energy, 0.3, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	anim.play("on")
