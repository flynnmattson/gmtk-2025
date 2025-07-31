extends Node

@export var raycast : RayCast3D
@export var hold_location: Node3D
@export var throw_power: int = 10

var active_throwable: Throwable

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider is Interactable:
				var interactable = collider as Interactable
				interactable.interact()
			if collider is Throwable and active_throwable == null:
				active_throwable = collider as Throwable
				active_throwable.get_parent().remove_child(active_throwable)
				hold_location.add_child(active_throwable)
				active_throwable.hold()
				active_throwable.global_position = hold_location.global_position

	if Input.is_action_just_pressed("attack") and active_throwable:
		var world_objects: Node3D = get_tree().get_first_node_in_group("WorldObjects")
		hold_location.remove_child(active_throwable)
		world_objects.add_child(active_throwable)
		active_throwable.global_position = hold_location.global_position
		active_throwable.let_go()
		var direction = raycast.global_position.direction_to(raycast.to_global(raycast.target_position))
		direction.y += randf_range(0.25, 0.5)
		active_throwable.apply_central_impulse(direction * throw_power)
		active_throwable = null
