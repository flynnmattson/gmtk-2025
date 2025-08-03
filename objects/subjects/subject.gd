class_name Subject extends CharacterBody3D

@onready var target_ray_cast_3d: RayCast3D = $TargetRayCast3D
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var hold_location: Node3D = %HoldLocation
@onready var voice_controller: VoiceController = $VoiceController

@export var base_speed : float = 4.0
@export var throw_power: int = 20
@export var throw_cooldown: float = 1.0
@export var gravity_enabled : bool = true
@export var active_rage_limit: int = 1
@export var death_rage_limit: int = 5

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity") # Don't set this as a const, see the gravity section in _physics_process
var current_rage: int = 0
var face_target: Node3D
var last_throwable: Throwable


func _physics_process(delta: float) -> void:
	if not is_on_floor() and gravity and gravity_enabled:
		velocity.y -= gravity * delta

	var input_dir = Vector2.ZERO

	_handle_movement(input_dir)
	_handle_look(delta)


func hit(throwable: Throwable) -> bool:
	if throwable == last_throwable:
		return false

	if is_dead() and animation_player.assigned_animation != "Death":
		animation_player.play("Death")

	if not is_dead():
		print("hit")
		current_rage += 1
		if is_dead():
			voice_controller.play_death()
			animation_player.play("Death")
			GameEvent.emit_subject_silenced()
		elif current_rage == active_rage_limit:
			voice_controller.play_enrage()
			if animation_player.has_animation("Yelling"):
				animation_player.play("Yelling")
			GameEvent.emit_rage_started()
		else:
			voice_controller.play_hit()
			animation_player.play_section("IsHit", 0.2)
	return true

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
