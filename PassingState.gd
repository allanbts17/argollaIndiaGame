class_name PassingState extends StateBase

@onready var tree: SceneTree = get_tree()
@onready var ring: Ring = get_node("/root/Main/argolla") as Ring

func init(id: int, stateName: String):
	self.id = id
	self.stateName = stateName

func start():
	started = true
	#Colocar un timer
	Utils.wait(Utils.randomNumberf(1,3))
	passToNearest()
	pass

func passToNearest():
	if master is Player:
		if master.has_ring:
			var partners = getPartnerList()
			var distance = null
			var target: Vector2
			print(partners)
			for partner in partners:
				if distance == null or distance > master.position.distance_to(partner.position):
					distance = master.position.distance_to(partner.position)
					target = partner.position
			prints("target:",target)
			ring.moveToTarget(target)
		pass
	pass
	
func end() -> int:
	started = false
	#Some logic
	return nextStateId



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started:
		pass
	pass
	
func getPartnerList() -> Array[Player]:
	var isPartner = func (player: Player):
		var partner = player.teamId == master.teamId
		return partner and player != master
	var list = tree.get_nodes_in_group('players')
	#prints("list:",list)
	var plList: Array[Player] = []
	for item in list:
		#prints("teamIDs",item.teamId,master.teamId)
		plList.append(item)
	var rawList: Array[Player] = plList
	var partnerList: Array[Player] = rawList.filter(isPartner)
	return partnerList

