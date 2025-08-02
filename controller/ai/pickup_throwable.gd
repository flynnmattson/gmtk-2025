@tool
extends ActionLeaf


func before_run(actor: Node, blackboard: Blackboard) -> void:
	actor.velocity = Vector3.ZERO


func tick(actor: Node, blackboard: Blackboard) -> int:
	var throwable = blackboard.get_value("throwable") as Throwable
	var hold_location = blackboard.get_value("hold_location") as Node3D
	if throwable == null or hold_location == null:
		return FAILURE

	throwable.get_parent().remove_child(throwable)
	hold_location.add_child(throwable)
	throwable.hold()
	throwable.global_position = hold_location.global_position
	return SUCCESS
