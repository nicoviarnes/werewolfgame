extends CanvasLayer

onready var score = $Score
onready var night_warning = $NightWarning
onready var day_warning = $SunWarning
onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	ScoreManager.connect("update", self, "_update_score")


func _update_score(i):
	score.text = "Score: " + str(ScoreManager.score)
	$FCTManager.show_value(null, i, true, false)


func _on_CycleTimerUI_warning(day):
	if day:
		night_warning.visible = true
	else:
		day_warning.visible = true
	timer.start()

func _on_Timer_timeout():
	night_warning.visible = false
	day_warning.visible = false
