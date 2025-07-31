class_name Throwable extends RigidBody3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func hold() -> void:
	freeze = true
	collision_shape_3d.disabled = true

func let_go() -> void:
	freeze = false
	collision_shape_3d.disabled = false
