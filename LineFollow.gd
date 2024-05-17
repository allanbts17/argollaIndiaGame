extends Node2D

var index = 0
var selected_line: TrackLine
var selected_line_key
var track_detection_radius = 10
@onready var player: Player = get_parent()
@onready var trackInput: TrackInput = get_parent().get_parent().get_node("trackInput")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tracked_movement()
	pass
	
func tracked_movement():
	if not selected_line:
		for line in trackInput.linesDict.keys():
			if player.position.distance_to(trackInput.linesDict[line].track_points[0]) <= track_detection_radius:
				selected_line = trackInput.linesDict[line]
				selected_line_key = line
	if selected_line and selected_line.build_finished:
		selected_line.movement_started = true
		selected_line.track_points = Utils.reduce(selected_line.track_points,0.3)
		# Verificar si hemos alcanzado el punto actual
		if player.position.distance_to(selected_line.track_points[index]) < 5 and index < selected_line.track_points.size():
			index += 1
		# Si hemos llegado al final del trayecto, reiniciamos
		if index >= selected_line.track_points.size():
			player.direction = Vector2.ZERO
			index = 0
			
			trackInput.removeTrack(selected_line_key)
			selected_line_key = null
			selected_line = null
			return
		# Calcular la dirección hacia el siguiente punto
		var dir: Vector2
		prints(index,selected_line.track_points.size())
		dir = (selected_line.track_points[index] - player.position)
		player.direction = dir.normalized()
