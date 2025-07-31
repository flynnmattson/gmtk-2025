extends Node

@export var raycast : RayCast3D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider is Interactable:
				var interactable = collider as Interactable
				interactable.interact()
