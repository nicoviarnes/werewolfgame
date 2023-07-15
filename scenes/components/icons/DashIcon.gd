extends TextureRect

onready var mask = $ColorRect
onready var sweep = $Sweep
onready var timer = $Timer

onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	player.connect("dash", self, "_on_player_dash")
	player.connect("in_bush", self, "_on_player_in_bush")
	sweep.value = 0
	set_process(false)


func _process(delta):
	sweep.value = int((timer.time_left / 3.0) * 100)
	

func _on_Timer_timeout():
	sweep.value = 0
	set_process(false)


func _on_player_dash():
	set_process(true)
	timer.start()


func _on_player_in_bush(in_bush):
	if in_bush:
		mask.visible = true
	else:
		mask.visible = false
