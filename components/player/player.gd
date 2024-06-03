@tool
class_name Player extends PlayerStats

@export var SPEED: float = 100.0
@export var CONTROL_MOVEMENT = false
@export var teamId = 0
@export var userControl = false
@export var has_ring = false
@export_enum("Rojo", "Azul", "Verde","Neutro") var color := 3: set = set_property, get = get_property
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var ring: Area2D = get_parent().get_node("argolla")
@onready var stateMachine: StateMachine = get_node("StateMachine")
@onready var passingState: PassingState = $StateMachine/PassingState


const JUMP_VELOCITY = -200.0
var direction: Vector2
const GRAVITY = 500
var is_jumping = false
var can_stop_falling = false
var jump_start_height = 0
var avoidRadius = 60

func set_property(_color):
	print(_color)
	color = _color
	if _color == 0:
		modulate = Color("ff0004")
	elif _color == 1:
		modulate = Color("3300ff")
	elif _color == 2:
		modulate = Color("00ff39")
	elif _color == 3:
		modulate = Color("ffffff")
	
func get_property():
	return color

# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	animation_tree.active
	animation_tree["parameters/conditions/is_moving"] = false
	animation_tree["parameters/conditions/is_stoping"] = true
	animation_tree["parameters/idle/blend_position"] = Vector2.UP
	add_to_group('players')
	#print(passingState)
	
	#Utils.timer(2,func (e): passingState.start(),[1])

	
	
func _process(delta):
	animation_tree.advance(delta*3.5)
	update_animation_parameters(direction)
	
func _physics_process(delta):
	if CONTROL_MOVEMENT:
		direction = Input.get_vector("left","right","up","down").normalized()
	#print(direction)

	if not is_jumping:
		if direction:
			velocity = direction * SPEED
		else:
			velocity = Vector2.ZERO

#	if Input.is_action_just_pressed("jump") and not is_jumping:
#		jump_start_height = position.y
#		prints("jump start height:",jump_start_height)
#		is_jumping = true
#		velocity.y += JUMP_VELOCITY
#
#	if is_jumping:
#		velocity.y += GRAVITY * delta
#		if position.y <= jump_start_height - 1:
#			#prints("now can stop falling",position.y,jump_start_height)
#			can_stop_falling = true
#		if can_stop_falling and position.y >= jump_start_height:
#			position.y = jump_start_height
#			is_jumping = false
#			can_stop_falling = false
	move_and_slide()
#	if has_ring and ring:
#		ring.position = position
	

	
func update_animation_parameters(direction: Vector2):
	direction = direction*Vector2(1,-1)
	if is_jumping:
		animation_tree["parameters/conditions/is_jumping"] = true
		animation_tree["parameters/conditions/is_moving"] = false
		animation_tree["parameters/conditions/is_stoping"] = false
	else:
		if(velocity == Vector2.ZERO):
			animation_tree["parameters/conditions/is_moving"] = false
			animation_tree["parameters/conditions/is_stoping"] = true
			animation_tree["parameters/conditions/is_jumping"] = false

		else:
			animation_tree["parameters/conditions/is_moving"] = true
			animation_tree["parameters/conditions/is_stoping"] = false
			animation_tree["parameters/conditions/is_jumping"] = false
	if direction != Vector2.ZERO:
		animation_tree["parameters/walk/blend_position"] = direction
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/jump/blend_position"] = direction

