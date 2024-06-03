extends Area2D
class_name Ring

var targetPosition: Vector2
var isMoving = false
var canMove = false
# Called when the node enters the scene tree for the first time.
func _input(event):
	return
	#print(event)
	if event is InputEventMouseMotion:
		canMove = false
	if event is InputEventMouseButton:
		if not event.pressed and canMove:
			targetPosition = event.position
			isMoving = true
			#print(event)
			print("target pos:",targetPosition)
			canMove = false
		else:
			canMove = true
	pass # Replace with function body.

func moveToTarget(target: Vector2):
	targetPosition = target
	isMoving = true

func _process(delta):
	#print(isMoving,position,targetPosition)
	if isMoving:
		position += position.direction_to(targetPosition)*delta*400
		if position.distance_to(targetPosition) <= 3:
			position = targetPosition
			isMoving = false
	pass
