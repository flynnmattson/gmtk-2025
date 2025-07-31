extends Interactable

@export var animation_player: AnimationPlayer

func interact() -> void:
	animation_player.play("open")
