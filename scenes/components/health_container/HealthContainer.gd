extends HBoxContainer


export var heart_sprite : PackedScene

var hearts = 5
var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_nodes_in_group("player")[0]
	player.connect("hurt", self, "_on_Player_hurt")
	player.connect("health_pickup", self, "_on_Player_health_pickup")
	for heart in hearts:
		var new_heart = heart_sprite.instance()
		add_child(new_heart)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_hurt():
	if not game_over:
		AudioManager.play(load("res://assets/sounds/player/hurt.wav"), "SFX", 0)
		if hearts - 1 == 0:
			end_game()

		hearts -= 1
		if not get_children().empty():
			var lost_heart = get_children().pop_back()
			lost_heart.queue_free()
	

func _on_Player_health_pickup():
	if hearts == 5:
		return
	else:
		hearts += 1
		var new_heart = heart_sprite.instance()
		add_child(new_heart)


func end_game():
	game_over = true
	for child in get_children():
		child.queue_free()
	AudioManager.clear_all_audio()
	var SceneManager = get_tree().get_nodes_in_group("SceneManager")[0]
	SceneManager.change_scene(3)
