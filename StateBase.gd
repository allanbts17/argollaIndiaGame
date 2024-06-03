class_name StateBase extends Node2D

@onready var master: Node = get_parent().get_parent()

var id: int
var stateName: String
var nextStateId: int
var started = false

func init(id: int, stateName: String):
	self.id = id
	self.stateName = stateName

func start():
	started = true
	pass
	
func end() -> int:
	started = false
	#Some logic
	return nextStateId



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started:
		pass
	pass
