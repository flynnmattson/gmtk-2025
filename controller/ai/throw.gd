@tool
extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")
	var throwable = blackboard.get_value("throwable") as Throwable
	var hold_location = blackboard.get_value("hold_location") as Node3D
	if throwable == null or player == null or hold_location == null:
		return FAILURE

	var throwables: Node = get_tree().get_first_node_in_group("Throwables")
	hold_location.remove_child(throwable)
	throwables.add_child(throwable)
	throwable.global_position = hold_location.global_position
	throwable.throw()
	var direction = hold_location.global_position.direction_to(player.global_position)
	direction.x += randf_range(-0.1, 0.1)
	direction.z += randf_range(-0.1, 0.1)
	direction.y = 0.0 + randf_range(0.1, 0.2)
	throwable.apply_central_impulse(direction * actor.throw_power)
	blackboard.erase_value("throwable")
	return SUCCESS
