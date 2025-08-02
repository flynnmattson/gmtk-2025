@tool
extends ConditionLeaf

func tick(_actor: Node, blackboard: Blackboard) -> int:
	var enraged: bool = blackboard.get_value("enraged", false)
	if enraged:
		return SUCCESS
	else:
		return FAILURE
