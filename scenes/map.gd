extends Node

@onready var battle_area: Area3D = $BattleArea


var in_battle: bool = false


func _ready() -> void:
	battle_area.body_entered.connect(_battle_entered)
	GameEvent.regenerate.connect(_out_of_battle)


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
	
