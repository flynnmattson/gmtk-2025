extends Node

signal start_game()
signal rage_started()
signal subject_silenced()


func emit_start_game() -> void:
	start_game.emit()


func emit_rage_started() -> void:
	rage_started.emit()


func emit_subject_silenced() -> void:
	subject_silenced.emit()
