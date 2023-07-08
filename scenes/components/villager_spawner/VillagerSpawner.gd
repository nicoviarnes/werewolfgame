extends Position2D

onready var timer = $Timer

export var amount_to_spawn :int
export var villager_scene : PackedScene

var villager_01 = load("res://resources/villager_01.tres")
var villager_02 = load("res://resources/villager_02.tres")
var villager_03 = load("res://resources/villager_03.tres")
var villager_04 = load("res://resources/villager_04.tres")
var villager_05 = load("res://resources/villager_05.tres")
var villager_06 = load("res://resources/villager_06.tres")

var possible_villagers = [villager_01, villager_02, villager_03, villager_04, villager_05, villager_06]
var villagers_full = []


# Called when the node enters the scene tree for the first time.
func _ready():
	villagers_full = possible_villagers.duplicate()
	possible_villagers.shuffle()
	for i in amount_to_spawn:
		make_villager()


func make_villager():
	if possible_villagers.empty():
		possible_villagers = villagers_full.duplicate()
		possible_villagers.shuffle()

	var random_villager = possible_villagers.pop_front()
	var villager = villager_scene.instance()
	var day_night_cycle = get_tree().get_nodes_in_group("cycle")[0]
	day_night_cycle.connect("day", villager, "_on_day")
	day_night_cycle.connect("night", villager, "_on_night")
	villager.global_position = global_position
	villager.get_node("Sprite").frames = random_villager
	get_tree().get_root().call_deferred("add_child", villager)
	timer.start()




func _on_Timer_timeout():
	if CycleManager.daytime:
		if get_tree().get_nodes_in_group("villager").size() < 100:
			make_villager()
	else:
		timer.start()
	
