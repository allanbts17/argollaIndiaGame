class_name Player extends CharacterBody2D

@export var SPEED: float = 100.0
@export var CONTROL_MOVEMENT = true
const JUMP_VELOCITY = -200.0
@onready var animation_tree: AnimationTree = $AnimationTree
var direction: Vector2
const GRAVITY = 500
var is_jumping = false
var can_stop_falling = false
var jump_start_height = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	animation_tree.active
	animation_tree["parameters/conditions/is_moving"] = false
	animation_tree["parameters/conditions/is_stoping"] = true
	animation_tree["parameters/idle/blend_position"] = Vector2.UP
	
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
#
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

