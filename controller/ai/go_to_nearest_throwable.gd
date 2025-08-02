@tool
extends ActionLeaf

@export var necessary_distance: float = 2.0
@export var reset_limit: float = 5.0

var nearest_throwable: Throwable
var timer: Timer


func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true


func before_run(actor: Node, _blackboard: Blackboard) -> void:
	var throwables: Node = get_tree().get_first_node_in_group("Throwables")
	var closest_distance: float = 9999999

	for throwable: Throwable in throwables.get_children():
		var distance: float = actor.global_position.distance_to(throwable.global_position)
		if distance < closest_distance:
			nearest_throwable = throwable
			closest_distance = distance

	if not nearest_throwable == null:
		timer.start(reset_limit)
		actor.face_target = nearest_throwable


func tick(actor: Node, blackboard: Blackboard) -> int:
	if nearest_throwable == null or timer.is_stopped():
		return FAILURE
	if _target_reached(actor):
		blackboard.set_value("throwable", nearest_throwable)
		return SUCCESS

	_go_to_target(actor)
	return RUNNING


func _target_reached(actor: Node) -> bool:
	if actor.global_position.distance_to(nearest_throwable.global_position) < necessary_distance:
		return true
	return false


func _go_to_target(actor: Node) -> void:
	var direction = actor.global_position.direction_to(nearest_throwable.global_position)
	
	actor.velocity.x = direction.x * actor.base_speed
	actor.velocity.z = direction.z * actor.base_speed
