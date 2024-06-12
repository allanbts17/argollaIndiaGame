class_name AvoidState extends StateBase

@onready var tree: SceneTree = get_tree()

var rivals: Array[Player]

func init(id: int, stateName: String):
	self.id = id
	self.stateName = stateName

func start():
	rivals = getRivalList()
	started = true
	pass
	
func end() -> int:
	started = false
	#Some logic
	return nextStateId
	
func _process(delta):
	if started:
		var player = master as Player
		player.avoidRadius
		var rivalDirections: Array[Vector2] = []
		for rival in rivals:
			if player.position.distance_to(rival.position) <= player.avoidRadius:
				#Mover el jugador
				rivalDirections.append(rival.position.direction_to(player.position))
				pass
		
		var directionSum: Vector2 = rivalDirections.reduce(func(acum,num): return acum + num,Vector2.ZERO)
		directionSum = directionSum.normalized()
		player.direction = directionSum
		rivalDirections = []
	pass
	
func getRivalList() -> Array[Player]:
	var isRival = func (player: Player):
		var rival = player.teamId != master.teamId
		return rival and player != master
	var list = tree.get_nodes_in_group('players')
	#prints("list:",list)
	var plList: Array[Player] = []
	for item in list:
		#prints("teamIDs",item.teamId,master.teamId)
		plList.append(item)
	var rawList: Array[Player] = plList
	var rivalList: Array[Player] = rawList.filter(isRival)
	return rivalList
	

