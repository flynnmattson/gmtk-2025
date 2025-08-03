extends CanvasLayer


@onready var return_button: Button = %Return


func _ready() -> void:
	GameEvent.controls.connect(_show)
	return_button.pressed.connect(_return)


func _show() -> void:
	visible = true


func _return() -> void:
	visible = false
