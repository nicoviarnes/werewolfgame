extends Node

signal update
var score = 0


func update_score(new_score):
	score += new_score
	emit_signal("update")
