extends Node

signal start_game()
signal rage_started()
signal subject_silenced()
signal stupidity_spread()
signal brain_dead()
signal door_action(open: bool)
signal initiate_battle()
signal battle_over()
signal regenerate(amount: int)


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


func emit_door_action(open: bool) -> void:
	door_action.emit(open)


func emit_initiate_battle() -> void:
	initiate_battle.emit()


func emit_regenerate(amount: int) -> void:
	regenerate.emit(amount)


func emit_battle_over() -> void:
	battle_over.emit()
