extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play(load("res://assets/sounds/game_over_music.wav"), "Music", 0)


func _on_menu_pressed():
	AudioManager.clear_all_audio()
	AudioManager.play(load("res://assets/sounds/menu_music.wav"), "Music", 0)
