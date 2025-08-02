@tool
extends ConditionLeaf

func tick(_actor: Node, blackboard: Blackboard) -> int:
	var alive: bool = blackboard.get_value("alive", true)
	if alive:
		return SUCCESS
	else:
		return FAILURE
