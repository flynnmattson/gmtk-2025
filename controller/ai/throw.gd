@tool
extends ActionLeaf

var player: CharacterBody3D
var thrown: bool = false
var timer: Timer


func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)


func before_run(actor: Node, blackboard: Blackboard) -> void:
	player = get_tree().get_first_node_in_group("Player")
	actor.face_target = player
	thrown = false


func tick(actor: Node, blackboard: Blackboard) -> int:
	var throwable = blackboard.get_value("throwable") as Throwable
	if throwable == null or actor.is_dead():
		return FAILURE

	if thrown:
		var hold_location = blackboard.get_value("hold_location") as Node3D
		var throwables: Node = get_tree().get_first_node_in_group("ThrowableParent")
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

	var collider: Object = actor.target_ray_cast_3d.get_collider()
	if not collider == null and collider.is_in_group("Player") and timer.is_stopped():
		thrown = false
		var animation_player = blackboard.get_value("animation_player")
		animation_player.play("Throw")
		timer.start(0.8)

	return RUNNING


func _on_timeout() -> void:
	thrown = true
