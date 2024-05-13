extends Node2D

@onready var trackInput: TrackInput = $trackInput
@onready var player: Player = $player
var index = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not trackInput.startTrack and trackInput.points.size() > 0 and index < trackInput.points.size():
		trackInput.points = reduce(trackInput.points,0.3)
		# Verificar si hemos alcanzado el punto actual
		if player.position.distance_to(trackInput.points[index]) < 5 and index < trackInput.points.size():
			index += 1
		# Si hemos llegado al final del trayecto, reiniciamos
		if index >= trackInput.points.size():
			player.direction = Vector2.ZERO
			return
	
		# Calcular la dirección hacia el siguiente punto
		var dir: Vector2
		prints(index,trackInput.points.size())
		dir = (trackInput.points[index] - player.position)

		player.direction = dir.normalized()
		
func reduce(array: Array, reduction: float) -> Array:
	var length = array.size()
	var new_length = round(length * reduction)
	var step = round(length / new_length)
	#new_length = snappedi(length,step)
	var new_array = []
	for index in range(0,length,step):
		new_array.append(array[index])
	return array
	
   

