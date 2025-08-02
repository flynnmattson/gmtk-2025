extends Node

@onready var current: Node = $Current
@onready var main_menu: MainMenu = $MainMenu
@onready var death_screen: CanvasLayer = $DeathScreen


@export var map: PackedScene


var map_scene: Node
var current_subject: Subject


func _ready() -> void:
	GameEvent.start_game.connect(_on_start_game)
	GameEvent.brain_dead.connect(_on_brain_dead)
	main_menu.visible = true


func _on_start_game() -> void:
	# in case of restart
	if not map_scene == null:
		current.remove_child(map_scene)
		map_scene = null

	map_scene = map.instantiate()
	current.add_child(map_scene)
	get_tree().paused = false
	main_menu.visible = false
	death_screen.visible = false


func _on_brain_dead() -> void:
	death_screen.visible = true
	get_tree().paused = true
