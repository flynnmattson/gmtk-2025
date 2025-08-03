class_name MainMenu extends CanvasLayer

@onready var start: Button = %Start
@onready var quit: Button = %Quit
@onready var controls: Button = %Controls


func _ready() -> void:
	start.pressed.connect(_start_game)
	quit.pressed.connect(_quit)
	controls.pressed.connect(GameEvent.emit_controls)


func _start_game() -> void:
	GameEvent.emit_start_game()


func _quit() -> void:
	get_tree().quit()
