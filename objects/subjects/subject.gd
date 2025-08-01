class_name Subject extends CharacterBody3D


@export var base_speed : float = 3.0
@export var gravity_enabled : bool = true

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity") # Don't set this as a const, see the gravity section in _physics_process

func _physics_process(delta: float) -> void:
	if not is_on_floor() and gravity and gravity_enabled:
		velocity.y -= gravity * delta
	
	var input_dir = Vector2.ZERO

	handle_movement(delta, input_dir)


func handle_movement(delta, input_dir) -> void:
	var direction = input_dir
	direction = Vector3(direction.x, 0, direction.y)
	move_and_slide()
