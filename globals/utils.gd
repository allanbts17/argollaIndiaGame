extends Node

	
func timer(seconds: float, func_ref: Callable, args):
	print("Inicio")
	await get_tree().create_timer(seconds).timeout
	func_ref.callv(args)


func reduce(array: Array, reduction: float) -> Array:
	var length = array.size()
	var new_length = round(length * reduction)
	var step = round(length / new_length)
	#new_length = snappedi(length,step)
	var new_array = []
	for index in range(0,length,step):
		new_array.append(array[index])
	return array
	
func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
	
func randomNumber(min: int,max: int) -> int:
	var rng = RandomNumberGenerator.new()
	rng.seed = Time.get_time_dict_from_system()['second']
	return rng.randi_range(min, max)

		
func randomNumberf(min: float,max: float) -> float:
	var rng = RandomNumberGenerator.new()
	rng.seed = Time.get_time_dict_from_system()['second']
	return rng.randf_range(min, max)

