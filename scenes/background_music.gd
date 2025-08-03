extends Node3D


@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

@export var calm: AudioStreamMP3
@export var combat: AudioStreamMP3


func _ready() -> void:
	audio_stream_player_3d.stream = calm
	audio_stream_player_3d.play()
	GameEvent.rage_started.connect(_combat)
	GameEvent.subject_silenced.connect(_calm)


func _combat() -> void:
	audio_stream_player_3d.stream = combat
	audio_stream_player_3d.play()
	

func _calm() -> void:
	audio_stream_player_3d.stream = calm
	audio_stream_player_3d.play()
