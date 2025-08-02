class_name Throwable extends RigidBody3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var is_thrown: bool = false
var is_picked: bool = false
var timer: Timer = Timer.new()

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func hold() -> void:
	freeze = true
	collision_shape_3d.disabled = true
	is_picked = true


func throw() -> void:
	freeze = false
	collision_shape_3d.disabled = false
	is_thrown = true
	is_picked = false


func _on_body_entered(body: Node) -> void:
	if body is Subject and is_thrown:
		var subject = body as Subject
		subject.hit()
		is_thrown = false
	
	if is_thrown and body.is_in_group("Ground"):
		is_thrown = false
