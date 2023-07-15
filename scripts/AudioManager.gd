extends Node

var num_players : int = 128  # How many AudioStreamPlayers to use
var available : Array = []  # The list of available players
var queue : Array = []  # The queue of sounds to play

func _ready() -> void:
	self.pause_mode = 2
	var main = get_tree().get_nodes_in_group("main")[0]
	for i in num_players: 
		var player = AudioStreamPlayer.new()
		player.pause_mode = 2
		player.add_to_group("audio_players")
		main.add_child(player)
		available.append(player)
		player.connect("finished", self, "_on_stream_finished", [player])


func _on_stream_finished(stream : AudioStreamPlayer) -> void:
	available.append(stream)


func play(sound : AudioStream, bus : String, volume : int) -> void:
	queue.append({"sound": sound, "bus": bus, "volume": volume})


func _process(_delta: float) -> void:
	if queue.empty() or available.empty(): # Early return strategy
		return
	var track = queue.pop_front()
	var audio_player = available.pop_front() # Create a reference to the AudioStreamPlayer we're working with
	audio_player.stream = track.sound
	audio_player.bus = track.bus
	audio_player.volume_db = track.volume
	audio_player.play()


#used for setting the bus volume eg. settings page with volume slider
func set_bus_volume(bus : String, volume : int) -> void:
	var bus_index = AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(bus_index, volume)


func clear_all_audio():
	var all_audio = get_tree().get_nodes_in_group("audio_players")
	for audio_player in all_audio:
		if audio_player.playing:
			audio_player.stop()
			available.append(audio_player)
