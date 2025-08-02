extends Node

@onready var battle_area: Area3D = $BattleArea
@onready var throwables: Node = %Throwables


var in_battle: bool = false


func _ready() -> void:
	battle_area.body_entered.connect(_battle_entered)
	GameEvent.regenerate.connect(_out_of_battle)
	GameEvent.battle_over.connect(_on_battle_over)


func set_subject(subject: Subject) -> void:
	pass


func _battle_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and not in_battle:
		in_battle = true
		GameEvent.emit_initiate_battle()


func _out_of_battle(amount: int) -> void:
	if in_battle:
		in_battle = false
		GameEvent.emit_battle_over()


func _on_battle_over() -> void:
	for throwable: Throwable in throwables.get_children():
		throwables.remove_child(throwable)
	var subject = get_tree().get_first_node_in_group("Subject")
	remove_child(subject)
