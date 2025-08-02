extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var brain_cells = 20
@export var brain_container: MarginContainer

var shrink_tween: Tween


func _ready() -> void:
	GameEvent.stupidity_spread.connect(_on_stupidity_spread)


func _on_stupidity_spread() -> void:
	brain_cells = brain_cells - 1
	animation_player.play("damage")
	if shrink_tween != null and shrink_tween.is_valid():
		shrink_tween.kill()
	shrink_tween = create_tween()
	var percent: float = 1.0 / brain_cells
	shrink_tween.tween_property(brain_container, "scale", brain_container.scale - Vector2(percent, percent), 1.0)

	if brain_cells == 0:
		GameEvent.emit_brain_dead()
