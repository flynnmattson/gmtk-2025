class_name Subject extends CharacterBody3D

@export var base_speed : float = 3.0
@export var throw_power: int = 20
@export var throw_cooldown: float = 2.0
@export var gravity_enabled : bool = true
@export var active_rage_limit: int = 1
@export var death_rage_limit: int = 10

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity") # Don't set this as a const, see the gravity section in _physics_process
var current_rage: int = 0


func _physics_process(delta: float) -> void:
	if not is_on_floor() and gravity and gravity_enabled:
		velocity.y -= gravity * delta

	var input_dir = Vector2.ZERO

	_handle_movement(delta, input_dir)

func hit() -> void:
	print("hit")
	current_rage += 1
	if current_rage > active_rage_limit:
		print("rage started")
		GameEvent.emit_rage_started()
	if is_dead():
		print("he dead")
		GameEvent.emit_subject_silenced()


func is_dead() -> bool:
	return current_rage > death_rage_limit


func _handle_movement(_delta, input_dir) -> void:
	var direction = input_dir
	direction = Vector3(direction.x, 0, direction.y)
	move_and_slide()
