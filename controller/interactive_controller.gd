extends Node

@export var raycast : RayCast3D
@export var hold_location: Node3D
@export var throw_power: int = 10
@export var interact_container: MarginContainer


var active_throwable: Throwable

func _ready() -> void:
	interact_container.visible = false


func _process(_delta: float) -> void:
	_refresh_indicator()

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
		var throwables: Node = get_tree().get_first_node_in_group("ThrowableParent")
		hold_location.remove_child(active_throwable)
		throwables.add_child(active_throwable)
		active_throwable.global_position = hold_location.global_position
		active_throwable.throw()
		var direction = raycast.global_position.direction_to(raycast.to_global(raycast.target_position))
		direction.y += randf_range(0.2, 0.3)
		active_throwable.apply_central_impulse(direction * throw_power)
		active_throwable = null


func _refresh_indicator() -> void:
	var collider = raycast.get_collider()
	if collider is Interactable or (collider is Throwable and not collider.is_thrown):
		interact_container.visible = true
	else:
		interact_container.visible = false
