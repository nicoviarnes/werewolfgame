extends Node

var num_players : int = 128  # How many AudioStreamPlayers to use
var available : Array = []  # The list of available players
var queue : Array = []  # The queue of sounds to play

func _ready() -> void:
	for i in num_players: 
		var player = AudioStreamPlayer.new()
		add_child(player)
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
