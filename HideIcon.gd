extends TextureRect

onready var mask = $ColorRect
onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	player.connect("near_bush", self, "_on_player_near_bush")


func _on_player_near_bush(near_bush):
	if near_bush:
		mask.visible = false
	else:
		mask.visible = true
