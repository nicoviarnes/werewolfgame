extends CanvasLayer

onready var anim = $AnimationPlayer
onready var upgrade_panel = $UpgradePanel
onready var tween = $Tween

var hidden_position = Vector2(0, -360)
var shown_position = Vector2(0, 0)

var scene_list = [
	preload("res://scenes/MainMenu/MainMenu.tscn"), # 0
	preload("res://scenes/UI/settings_menu/SettingsMenu.tscn"), # 1
	preload("res://scenes/world/World.tscn"), # 2
	preload("res://scenes/UI/GameOverMenu/GameOver.tscn"), # 3
	preload("res://scenes/UI/tutorial/Tutorial.tscn") # 4
]

func change_scene(target: int) -> void:
	anim.play("dissolve")
	yield(anim, "animation_finished")
	var scene_container = get_tree().get_nodes_in_group("scene_container")[0]
	for child in scene_container.get_children():
		child.queue_free()
	var new_scene = scene_list[target].instance()
	scene_container.add_child(new_scene)
	anim.play_backwards("dissolve")
	

func show_upgrade_panel():
	tween.interpolate_property(upgrade_panel, "rect_position", hidden_position, shown_position, .5)
	tween.start()
	get_tree().paused = true


func hide_upgrade_panel():
	tween.interpolate_property(upgrade_panel, "rect_position", shown_position, hidden_position, .5)
	tween.start()
	get_tree().paused = false
	upgrade_panel.get_node("Accept").visible = false
