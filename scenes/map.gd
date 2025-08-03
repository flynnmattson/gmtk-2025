extends Node


@onready var battle_area: Area3D = $BattleArea
@onready var throwables: Node = %Throwables
@onready var subject_spawn: Node3D = $SubjectSpawn
@onready var possession_spawn: Node3D = $PossessionSpawn


@export var subjects: Array[PackedScene] = []
@export var possessions: Array[PackedScene] = []


var battle_index = 0
var in_battle: bool = false


func _ready() -> void:
	battle_area.body_entered.connect(_battle_entered)
	GameEvent.regenerate.connect(_out_of_battle)
	GameEvent.battle_over.connect(_on_battle_over)
	_setup_battle()


func _battle_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and not in_battle:
		in_battle = true
		GameEvent.emit_initiate_battle()


func _out_of_battle(amount: int) -> void:
	if in_battle:
		in_battle = false
		GameEvent.emit_battle_over()


func _on_battle_over() -> void:
	for throwable in throwables.get_children():
		throwables.remove_child(throwable)
	var subject = get_tree().get_first_node_in_group("Subject")
	remove_child(subject)
	battle_index = battle_index + 1
	_setup_battle()


func _setup_battle() -> void:
	if battle_index < subjects.size():
		var subject = subjects[battle_index].instantiate()
		add_child(subject)
		subject.global_position = subject_spawn.global_position

		var possession = possessions[battle_index].instantiate()
		throwables.add_child(possession)
		possession.global_position = possession_spawn.global_position
