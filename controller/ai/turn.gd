@tool
extends ActionLeaf


var player: CharacterBody3D


func before_run(actor: Node, _blackboard: Blackboard) -> void:
	player = get_tree().get_first_node_in_group("Player")
	
