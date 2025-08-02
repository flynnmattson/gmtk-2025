extends Node

@export var quips: Array[AudioStream]

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timeout)


func _on_timeout() -> void:
	print("something stupid...")
	GameEvent.emit_stupidity_spread()
