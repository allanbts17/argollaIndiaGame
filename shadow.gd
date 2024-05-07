extends Node2D

@onready var character: CharacterBody2D = get_parent()
# Called when the node enters the scene tree for the first time.
var last_position
var jumping = false
func _ready():
	last_position = character.position
	last_position.y += 10
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if character.is_jumping:
		jumping = true
		#global_position.y = last_position.y
		#print("jumping")
	else:
		pass
		#position = Vector2.ZERO
		#last_position = global_position
		#print(last_position, global_position)

	
	pass
