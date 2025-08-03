class_name Brain extends StaticBody3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timeout)


func roll_credits() -> void:
	timer.start()
	audio_stream_player_3d.play()


func _on_timeout():
	GameEvent.emit_credits()
