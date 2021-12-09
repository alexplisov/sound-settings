extends VBoxContainer


export(String) var label
export(String) var bus_name
export(NodePath) var audio_stream_player_path


var audio_stream_player: AudioStreamPlayer


onready var play_button = $HBoxContainer/Play
onready var stop_button = $HBoxContainer/Stop
onready var bus_idx = AudioServer.get_bus_index(bus_name)


func _ready():
	$Label.text = label
	audio_stream_player = get_node(audio_stream_player_path)
	$HSlider.value = AudioServer.get_bus_volume_db(bus_idx)


func _on_HSlider_value_changed(value):
	if value > $HSlider.min_value:
		AudioServer.set_bus_mute(bus_idx, false)
		AudioServer.set_bus_volume_db(bus_idx, value)
	else:
		AudioServer.set_bus_mute(bus_idx, true)


func _on_Play_pressed():
	audio_stream_player.play()
	play_button.disabled = true
	stop_button.disabled = false


func _on_Stop_pressed():
	audio_stream_player.stop()
	play_button.disabled = false
	stop_button.disabled = true
