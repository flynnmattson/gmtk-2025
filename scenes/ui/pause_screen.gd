extends CanvasLayer

@onready var restart: Button = %Restart
@onready var quit: Button = %Quit
@onready var resume: Button = %Resume


func _ready() -> void:
	restart.pressed.connect(GameEvent.emit_start_game)
	quit.pressed.connect(_quit)
	resume.pressed.connect(GameEvent.emit_resume_game)


func _quit() -> void:
	get_tree().quit()
