extends CanvasLayer

@onready var exit: Button = %Exit
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	GameEvent.credits.connect(_show)
	exit.pressed.connect(_quit)


func _show() -> void:
	audio_stream_player.play()
	get_tree().paused = true
	visible = true


func _quit() -> void:
	get_tree().quit()
