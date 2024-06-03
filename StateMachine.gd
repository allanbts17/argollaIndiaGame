class_name StateMachine extends Node2D

var states: Array[StateBase]
var actualState: StateBase
@onready var master = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func init(initialStateId: int):
	actualState = states[initialStateId]
	actualState.start()


func nextState():
	actualState.end()
	actualState = states[actualState.nextStateId]
	actualState.start()
	#Podría emitir una señal
	pass
	
func end():
	actualState.end()
	pass

func set_state_array(states: Array[StateBase]):
	self.states = states
