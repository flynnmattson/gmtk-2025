class_name DoorInteractable extends Interactable

@export var animation_player: AnimationPlayer
@export var audio_stream_player: AudioStreamPlayer3D

var is_locked: bool = false
var is_open: bool = false


func _ready() -> void:
	GameEvent.initiate_battle.connect(_lock)
	GameEvent.subject_silenced.connect(_unlock)
	GameEvent.battle_over.connect(_shut)


func interact() -> void:
	if not is_locked and not animation_player.is_playing():
		audio_stream_player.play(0.5)
		if is_open:
			animation_player.play("close")
		else:
			animation_player.play("open")
		is_open = !is_open


func _lock() -> void:
	if is_open:
		audio_stream_player.play(0.5)
		animation_player.play("close")
		is_open = false
	is_locked = true


func _shut() -> void:
	if is_open:
		audio_stream_player.play(0.5)
		animation_player.play("close")
		is_open = false


func _unlock() -> void:
	if not is_open:
		audio_stream_player.play(0.5)
		animation_player.play("open")
		is_open = true
	is_locked = false
