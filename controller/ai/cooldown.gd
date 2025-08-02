@tool
extends ActionLeaf

var timer: Timer
var done: bool = false

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)

func before_run(actor: Node, blackboard: Blackboard) -> void:
	done = false
	timer.start(actor.throw_cooldown)


func tick(actor: Node, blackboard: Blackboard) -> int:
	if done:
		return SUCCESS
	return RUNNING


func _on_timeout() -> void:
	done = true
