extends Node3D

@onready var timer: Timer = $Timer
@onready var spawn_point: Node3D = $SpawnPoint

@export var item_list: Array[PackedScene] = []


func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	GameEvent.initiate_battle.connect(_start)
	GameEvent.subject_silenced.connect(_end)


func _start() -> void:
	_spawn()
	timer.start()


func _end() -> void:
	timer.stop()


func _on_timeout() -> void:
	_spawn()


func _spawn() -> void:
	if item_list.size() > 0:
		var index = randi_range(0, item_list.size() - 1)
		var item = item_list[index].instantiate() as Throwable
		var throwables: Node = get_tree().get_first_node_in_group("Throwables")
		throwables.add_child(item)
		item.global_position = spawn_point.global_position
