@tool
extends ActionLeaf


func before_run(actor: Node, blackboard: Blackboard) -> void:
	var animation_player = blackboard.get_value("animation_player") as AnimationPlayer
	if animation_player == null:
		return
	
	if actor.is_dead() and animation_player.assigned_animation != "Death":
		animation_player.play("Death")

	if not actor.is_dead():
		animation_player.play("Idle")
