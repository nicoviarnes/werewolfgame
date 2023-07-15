extends Node2D


func _ready():
	AudioManager.play(load("res://assets/sounds/menu_music.wav"), "Music", 0)
	randomize()
