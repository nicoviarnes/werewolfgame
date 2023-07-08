extends Sprite

var tree_01 = load("res://assets/props/nature/PNGs/Tree_01.png")
var tree_02 = load("res://assets/props/nature/PNGs/Tree_02.png")
var tree_03 = load("res://assets/props/nature/PNGs/Tree_03.png")
var tree_04 = load("res://assets/props/nature/PNGs/Tree_04.png")

var possible_trees = [tree_01, tree_02, tree_03, tree_04]

onready var player = get_tree().get_nodes_in_group("player")[0]
# Called when the node enters the scene tree for the first time.
func _ready():
	possible_trees.shuffle()
	var random_tree = possible_trees.pop_front()
	texture = random_tree


func _process(delta):
	if position - player.position >= OS.get_window_size():
		visible = false
	else:
		visible = true
