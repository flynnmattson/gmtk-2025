@tool
extends ActionLeaf


var player: CharacterBody3D
var timer: Timer
var direction: Vector3


func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true


func before_run(actor: Node, blackboard: Blackboard) -> void:
	player = get_tree().get_first_node_in_group("Player")
	var hold_location = blackboard.get_value("hold_location") as Node3D
	direction = hold_location.global_position.direction_to(player.global_position).rotated(Vector3.RIGHT, deg_to_rad(90))
	timer.start(0.4)


func after_run(actor: Node, blackboard: Blackboard) -> void:
	actor.velocity = Vector3.ZERO


func tick(actor: Node, blackboard: Blackboard) -> int:
	if timer.is_stopped():
		return SUCCESS
	
	actor.velocity = direction * 10.0
	return RUNNING
