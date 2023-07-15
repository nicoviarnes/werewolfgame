extends TextureButton

export var target : int
export var text : String

onready var tween = $Tween
onready var label = $Label

var initial_position = Vector2(7, 19.5)
var target_position = Vector2(7, 22.5)
var normal = true
var count = 0

func _ready():
	label.text = text

func _on_GameButton_pressed():
	AudioManager.play(load("res://assets/sounds/button_press.wav"), "SFX", 0)
	var SceneManager = get_tree().get_nodes_in_group("SceneManager")[0]
	SceneManager.change_scene(target)


func _on_GameButton_button_up():
	tween.interpolate_property(label, "rect_position", target_position, initial_position, .01)
	tween.start()


func _on_GameButton_button_down():
	tween.interpolate_property(label, "rect_position", initial_position, target_position, .01)
	tween.start()
