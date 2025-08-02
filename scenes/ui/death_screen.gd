extends CanvasLayer

@onready var restart: Button = %Restart
@onready var quit: Button = %Quit


func _ready() -> void:
	restart.pressed.connect(GameEvent.emit_start_game)
	quit.pressed.connect(_quit)


func _quit() -> void:
	get_tree().quit()
