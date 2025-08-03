extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var brain_cells: int = 30
@export var brain_container: MarginContainer


var shrink_tween: Tween
var grow_tween: Tween
var active_brain_cells: int
var percent: float

func _ready() -> void:
	GameEvent.stupidity_spread.connect(_on_stupidity_spread)
	GameEvent.regenerate.connect(_on_regenerate)
	active_brain_cells = brain_cells
	percent = 1.0 / brain_cells


func _on_stupidity_spread() -> void:
	active_brain_cells = active_brain_cells - 1
	animation_player.play("damage")
	if shrink_tween != null and shrink_tween.is_valid():
		shrink_tween.kill()
	shrink_tween = create_tween()
	shrink_tween.tween_property(brain_container, "scale", brain_container.scale - Vector2(percent, percent), 1.0)

	if active_brain_cells <= 0:
		GameEvent.emit_brain_dead()


func _on_regenerate(amount: int) -> void:
	if active_brain_cells < brain_cells:
		active_brain_cells = active_brain_cells + amount
		animation_player.play("heal")
		if grow_tween != null and grow_tween.is_valid():
			grow_tween.kill()
		grow_tween = create_tween()
		grow_tween.tween_property(brain_container, "scale", brain_container.scale + Vector2(percent, percent), 1.0)
