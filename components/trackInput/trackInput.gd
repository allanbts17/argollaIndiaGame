
class_name TrackInput extends Node2D
var startTrack = false
var linesDict = {}
var line_count = 0
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
		advance(event.position)
	if event is InputEventScreenTouch:
		if  event.pressed:
			initialize()
			advance(event.position)
		else:
			end()
	
func mouseInput(event):
	if event is InputEventMouseMotion:
		#Detecta el pressed
		if event.pressure == 1.0:
			initialize()
			advance(event.position)
		#Detecta el release
		elif event.pressure == 0.0 and startTrack:
			end()
			
			
func initialize():
	if not startTrack:
				linesDict[line_count] = TrackLine.new()
				linesDict[line_count].width = 3
				linesDict[line_count].name = "line" + str(line_count)
				add_child(linesDict[line_count])


func advance(pos: Vector2):
	linesDict[line_count].add_point(pos)
	linesDict[line_count].track_points.append(pos)
	startTrack = true
	
func end():
	startTrack = false
	linesDict[line_count].build_finished = true
	
	var execute = func(dict: Dictionary, line: TrackLine, lineKey: int):
		if not line.movement_started:
			removeTrack(lineKey)
			
	Utils.timer(0.2,execute,[linesDict,linesDict[line_count],line_count])
	line_count += 1

			
func removeTrack(key):
	linesDict.erase(key)
	get_node("line" + str(key)).queue_free()
	#startTrack = false
	#line2D: Line2D
	
