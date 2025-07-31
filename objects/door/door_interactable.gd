class_name DoorInteractable extends Interactable

@export var animation_player: AnimationPlayer

var is_locked: bool = false
var is_open: bool = false

func _ready() -> void:
	pass

func interact() -> void:
	if not is_locked and not animation_player.is_playing():
		if is_open:
			animation_player.play("close")
		else:
			animation_player.play("open")
		is_open = !is_open
