extends Node

@onready var timer: Timer = $Timer

@export var voice_controller: VoiceController


func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	GameEvent.initiate_battle.connect(_on_battle)
	GameEvent.subject_silenced.connect(_on_dead)


func _on_battle() -> void:
	if timer:
		timer.start()
		_talk()


func _on_timeout() -> void:
	_talk()


func _talk() -> void:
	voice_controller.play_regular()
	GameEvent.emit_stupidity_spread()


func _on_dead() -> void:
	timer.stop()
