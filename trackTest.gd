extends Node2D

var points = []
var startTrack = false
var line2D: Line2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _input(event):
	print(event)
	if event is InputEventScreenDrag:
		if startTrack:
			line2D.add_point(event.position)
			startTrack = true

	if event is InputEventScreenTouch:
		startTrack = event.pressed
		if startTrack:
			line2D = Line2D.new()
			line2D.width = 3
			add_child(line2D)
	
	
func mouseInput(event):
	if event is InputEventMouseMotion:
		if event.pressure == 1.0:
			if not startTrack:
				line2D = Line2D.new()
				line2D.width = 3
				add_child(line2D)
			line2D.add_point(event.position)
			startTrack = true
			
		elif event.pressure == 0.0 and startTrack:
			startTrack = false
