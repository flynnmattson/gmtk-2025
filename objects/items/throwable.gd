class_name Throwable extends RigidBody3D

var is_thrown: bool = false
var is_picked: bool = false
var timer: Timer = Timer.new()
var colliders: Array[CollisionShape3D] = []


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	var children = get_children()
	for child: Node in children:
		if child is CollisionShape3D:
			colliders.append(child)


func hold() -> void:
	freeze = true
	for collider in colliders:
		collider.disabled = true
	is_picked = true


func throw() -> void:
	freeze = false
	for collider in colliders:
		collider.disabled = false
	is_thrown = true
	is_picked = false


func _on_body_entered(body: Node) -> void:
	if is_thrown:
		if self.is_in_group("Possession") or body.is_in_group("Possession"):
			GameEvent.emit_possession_hit()

		if body is Subject:
			var subject = body as Subject
			if subject.hit(self):
				is_thrown = false

		if body.is_in_group("Ground"):
			is_thrown = false
