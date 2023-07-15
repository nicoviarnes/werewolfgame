extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play(load("res://assets/sounds/main_music.wav"), "Music", 0)
	ScoreManager.score = 0
	ExpManager.xp = 0
	ExpManager.level = 1
	ExpManager.levelup_xp = 100
	CycleManager.daytime = true
	CycleManager.max_time = 0.0
	CycleManager.time_left = 0.0
	SkillManager.skill_points = 0
	SkillManager.human_speed = 60
	SkillManager.wolf_speed = 100
	SkillManager.dash_length = 200


