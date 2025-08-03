class_name VoiceController extends Node3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


@export var regular: Array[AudioStreamMP3]
@export var enrage: Array[AudioStreamMP3]
@export var death: Array[AudioStreamMP3]
@export var hit: Array[AudioStreamMP3]
@export var possession: Array[AudioStreamMP3]


func play_regular() -> void:
	if regular.is_empty():
		return
	_play_stream(regular[randi_range(0, regular.size() - 1)])


func play_enrage() -> void:
	if enrage.is_empty():
		play_regular()
		return
	_play_stream(enrage[randi_range(0, enrage.size() - 1)])


func play_death() -> void:
	if death.is_empty():
		return
	_play_stream(death[randi_range(0, death.size() - 1)])


func play_hit() -> void:
	if hit.is_empty():
		return
	_play_stream(hit[randi_range(0, hit.size() - 1)])


func play_possession() -> void:
	if possession.is_empty():
		play_enrage()
		return
	_play_stream(possession[randi_range(0, possession.size() - 1)])


func _play_stream(stream: AudioStreamMP3) -> void:
	audio_stream_player_3d.stream = stream
	if not audio_stream_player_3d == null:
		audio_stream_player_3d.play()
