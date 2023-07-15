extends TextureRect

onready var points = $Points
onready var human_speed = $HSpeed
onready var wolf_speed = $WSpeed
onready var dash_length = $DashLength
onready var accept_button = $Accept



# Called when the node enters the scene tree for the first time.
func _ready():
	ExpManager.connect("level_up", self, "_on_level_up")


func _on_level_up():
	points.text = "Skill Points: " + str(SkillManager.skill_points)
	human_speed.text = "Human Speed: \n" + str(SkillManager.human_speed)
	wolf_speed.text = "Wolf Speed: \n" + str(SkillManager.wolf_speed)
	dash_length.text = "Dash Speed: \n" + str(SkillManager.dash_length)
	get_parent().show_upgrade_panel()


func _on_Accept_pressed():
	AudioManager.play(load("res://assets/sounds/button_press.wav"), "SFX", 0)
	if SkillManager.skill_points == 0:
		SkillManager.emit_signal("update_stats")
		get_parent().hide_upgrade_panel()
		$HSpeed/HspeedButton.visible = true
		$WSpeed/WSpeedButton.visible = true
		$DashLength/DashLenghtButton.visible = true
		return
	


func _on_HspeedButton_pressed():
	AudioManager.play(load("res://assets/sounds/button_press.wav"), "SFX", 0)
	if SkillManager.skill_points != 0:
		SkillManager.skill_points -= 1
		SkillManager.human_speed += 10
		human_speed.text = "Human Speed: \n" + str(SkillManager.human_speed)
		accept_button.visible = true
		points.text = "Skill Points: "  + str(SkillManager.skill_points)
		if SkillManager.skill_points == 0:
			$HSpeed/HspeedButton.visible = false
			$WSpeed/WSpeedButton.visible = false
			$DashLength/DashLenghtButton.visible = false


func _on_WSpeedButton_pressed():
	AudioManager.play(load("res://assets/sounds/button_press.wav"), "SFX", 0)
	if SkillManager.skill_points != 0:
		SkillManager.skill_points -= 1
		SkillManager.wolf_speed += 20
		wolf_speed.text = "Wolf Speed: \n" + str(SkillManager.wolf_speed)
		accept_button.visible = true
		points.text = "Skill Points: "  + str(SkillManager.skill_points)
		if SkillManager.skill_points == 0:
			$HSpeed/HspeedButton.visible = false
			$WSpeed/WSpeedButton.visible = false
			$DashLength/DashLenghtButton.visible = false

func _on_DashLenghtButton_pressed():
	AudioManager.play(load("res://assets/sounds/button_press.wav"), "SFX", 0)
	if SkillManager.skill_points != 0:
		SkillManager.skill_points -= 1
		SkillManager.dash_length += 50
		dash_length.text = "Dash Speed: \n" + str(SkillManager.dash_length)
		accept_button.visible = true
		points.text = "Skill Points: "  + str(SkillManager.skill_points)
		if SkillManager.skill_points == 0:
			$HSpeed/HspeedButton.visible = false
			$WSpeed/WSpeedButton.visible = false
			$DashLength/DashLenghtButton.visible = false
