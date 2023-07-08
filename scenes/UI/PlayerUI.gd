extends CanvasLayer

onready var score = $Score


# Called when the node enters the scene tree for the first time.
func _ready():
	ScoreManager.connect("update", self, "_update_score")


func _update_score():
	score.text = "Score: " + str(ScoreManager.score)
