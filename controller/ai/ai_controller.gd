extends Node

@onready var beehave_tree: BeehaveTree = $BeehaveTree
@onready var blackboard: Blackboard = $Blackboard

@export var actor: Node
@export var hold_location: Node3D
@export var animation_player: AnimationPlayer


func _ready() -> void:
	beehave_tree.actor = actor
	blackboard.set_value("enraged", false)
	blackboard.set_value("alive", true)
	blackboard.set_value("hold_location", hold_location)
	blackboard.set_value("animation_player", animation_player)
	GameEvent.rage_started.connect(_on_rage)
	GameEvent.subject_silenced.connect(_on_silenced)


func _on_rage() -> void:
	blackboard.set_value("enraged", true)


func _on_silenced() -> void:
	blackboard.set_value("alive", false)
