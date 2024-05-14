
class_name TrackInput extends Node2D

var points: Array = []
var startTrack = false
var line2D: Line2D
@export var debug = false

func _ready():
	pass # Replace with function body.

func _input(event):
	if debug:
		print(event)
		
	if getOS() == "Mobile":
		touchInput(event)
	else:
		mouseInput(event)
	
func getOS():
	match OS.get_name():
		"Windows":
			return "Desktop"
		"macOS":
			return "Desktop"
		"Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD":
			return "Desktop"
		"Android":
			return "Mobile"
		"iOS":
			return "Mobile"
		"Web":
			return "Web"


func touchInput(event):
	if event is InputEventScreenDrag:
		if startTrack:
			line2D.add_point(event.position)
			points.append(event.position)
			startTrack = true
	if event is InputEventScreenTouch:
		startTrack = event.pressed
		if startTrack:
			line2D = Line2D.new()
			line2D.width = 3
			add_child(line2D)
			points = []
	
func mouseInput(event):
	if event is InputEventMouseMotion:
		#Detecta el pressed
		if event.pressure == 1.0:
			if not startTrack:
				line2D = Line2D.new()
				line2D.width = 3
				add_child(line2D)
				points = []
			line2D.add_point(event.position)
			points.append(event.position)
			startTrack = true
		#Detecta el release
		elif event.pressure == 0.0 and startTrack:
			startTrack = false
			
func removeTrack():
	points = []
	startTrack = false
	#line2D: Line2D
	
