extends Sprite

onready var tween = $Tween
onready var light = $Light2D
onready var anim = $AnimationPlayer

func _ready():
	light.enabled = false
	light.energy = 0

func _on_day():
	tween.interpolate_property(light, "energy", light.energy, 0, 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	light.enabled = false
	anim.play("off")

func _on_night():
	light.enabled = true
	anim.play("on")
	tween.interpolate_property(light, "energy", light.energy, .8, 6.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
