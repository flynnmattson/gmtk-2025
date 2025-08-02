extends Node

signal start_game()
signal rage_started()
signal subject_silenced()
signal stupidity_spread()
signal brain_dead()


func emit_start_game() -> void:
	start_game.emit()


func emit_rage_started() -> void:
	rage_started.emit()


func emit_subject_silenced() -> void:
	subject_silenced.emit()


func emit_stupidity_spread() -> void:
	stupidity_spread.emit()


func emit_brain_dead() -> void:
	brain_dead.emit()
