extends CanvasLayer

onready var anim = $AnimationPlayer

var scene_list = [
	preload("res://scenes/MainMenu/MainMenu.tscn"),
	preload("res://scenes/UI/settings_menu/SettingsMenu.tscn"),
	preload("res://scenes/world/World.tscn"),
	preload("res://scenes/UI/GameOverMenu/GameOver.tscn")
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
	
