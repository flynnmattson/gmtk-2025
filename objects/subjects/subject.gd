class_name Subject extends CharacterBody3D

@onready var target_ray_cast_3d: RayCast3D = $TargetRayCast3D

@export var base_speed : float = 4.0
@export var throw_power: int = 20
@export var throw_cooldown: float = 2.0
@export var gravity_enabled : bool = true
@export var active_rage_limit: int = 1
@export var death_rage_limit: int = 5

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity") # Don't set this as a const, see the gravity section in _physics_process
var current_rage: int = 0
var face_target: Node3D


func _physics_process(delta: float) -> void:
	if not is_on_floor() and gravity and gravity_enabled:
		velocity.y -= gravity * delta

	var input_dir = Vector2.ZERO

	_handle_movement(input_dir)
	_handle_look(delta)


func hit() -> void:
	if not is_dead():
		print("hit")
		current_rage += 1
		if current_rage >= active_rage_limit:
			print("rage started")
			GameEvent.emit_rage_started()
		if is_dead():
			print("he dead")
			GameEvent.emit_subject_silenced()


func is_dead() -> bool:
	return current_rage > death_rage_limit


func _handle_movement(input_dir) -> void:
	var direction = input_dir
	direction = Vector3(direction.x, 0, direction.y)
	move_and_slide()


func _handle_look(delta) -> void:
	if not face_target == null:
		var pos: Vector2 = Vector2(global_position.x, global_position.z)
		var target_pos: Vector2 = Vector2(face_target.global_position.x, face_target.global_position.z)
		var direction = -(pos - target_pos)
		rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.y), delta * 3)
