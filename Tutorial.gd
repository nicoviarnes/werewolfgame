extends CanvasLayer

export var target : int

onready var forward_tween = $Forward/Tween
onready var backward_tween = $Back/Tween
onready var forward_label = $Forward/Label
onready var back_label = $Back/Label
onready var forward = $Forward
onready var backward = $Back
onready var panel_tween = $PanelTween

#onready var panel1 = $Panel1
#onready var panel2 = $Panel2
#onready var panel3 = $Panel3
#onready var panel4 = $Panel4
#onready var panel5 = $Panel5

var initial_position = Vector2(-15.5, 7.5)
var target_position = Vector2(-15.5, 10.5)
var normal = true
var count = 0

var points_dict = {"White": 50, "Yellow": 75, "Orange": 100}

#onready var panels = {
#	1: panel1, 
#	2: panel2,
#	3: panel3,
#	4: panel4,
#	5: panel5,
#}

var current_panel = 0
#onready var current_node = panel1
onready var panel_slider = $Control
onready var panel_timer = $Timer

func _ready():
	forward_label.text = "Next"
	back_label.text = "Back"


func change_panel(i):
	current_panel += i
	panel_tween.interpolate_property(panel_slider, "rect_position", panel_slider.rect_position, Vector2(panel_slider.rect_position.x + 640 * i, panel_slider.rect_position.y), .5)
	backward.visible = false
	forward.visible = false
	panel_timer.start()
	panel_tween.start()


func _on_Back_pressed():
	AudioManager.play(load("res://assets/sounds/button_press.wav"), "SFX", 0)
	if current_panel == 0:
		var SceneManager = get_tree().get_nodes_in_group("SceneManager")[0]
		SceneManager.change_scene(0)
	else:
		change_panel(1)


func _on_Back_button_up():
	backward_tween.interpolate_property(back_label, "rect_position", target_position, initial_position, .01)
	backward_tween.start()


func _on_Back_button_down():
	backward_tween.interpolate_property(back_label, "rect_position", initial_position, target_position, .01)
	backward_tween.start()


func _on_Forward_pressed():
	AudioManager.play(load("res://assets/sounds/button_press.wav"), "SFX", 0)
	if current_panel == -4:
		var SceneManager = get_tree().get_nodes_in_group("SceneManager")[0]
		AudioManager.clear_all_audio()
		SceneManager.change_scene(2)
	else:
		change_panel(-1)


func _on_Forward_button_up():
	forward_tween.interpolate_property(forward_label, "rect_position", target_position, initial_position, .01)
	forward_tween.start()


func _on_Forward_button_down():
	forward_tween.interpolate_property(forward_label, "rect_position", initial_position, target_position, .01)
	forward_tween.start()


func _on_Timer_timeout():
	backward.visible = true
	forward.visible = true
