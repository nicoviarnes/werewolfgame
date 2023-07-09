extends Node

export var health_pickup : PackedScene
export var exp_pickup : PackedScene
onready var timer = $Timer

func _on_Timer_timeout():
	timer.start()
	spawn_pickup()


func spawn_pickup():
	var random_spawns = []
	for child in get_children():
		if child != timer:
			random_spawns.append(child)
	if not random_spawns.empty():
		random_spawns.shuffle()
		var random_spawn_point = random_spawns.pop_front()
		var new_pickup
		if CycleManager.daytime:
			new_pickup = health_pickup.instance()
		else:
			new_pickup = exp_pickup.instance()
		new_pickup.global_position = random_spawn_point.global_position
		var container = get_tree().get_nodes_in_group("container")[0]
		container.call_deferred("add_child", new_pickup)
