class_name Grandma extends Node3D

@onready var heal_area_3d: Area3D = $HealArea3D
@onready var heal_timer: Timer = $HealTimer

@export var heal_amount: int = 1


var in_area: bool = false


func _ready() -> void:
	heal_area_3d.body_entered.connect(body_entered)
	heal_area_3d.body_exited.connect(body_exited)
	heal_timer.timeout.connect(heal)


func body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		in_area = true


func body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		in_area = false


func heal() -> void:
	if in_area:
		GameEvent.emit_regenerate(heal_amount)
