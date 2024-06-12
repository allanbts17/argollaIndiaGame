extends Node2D

@onready var avoidState: AvoidState = get_node("player8/StateMachine/AvoidState")


func _ready():
	Utils.timer(2,func (e): avoidState.start(),[1])
	pass
