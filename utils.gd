extends Node


func reduce(array: Array, reduction: float) -> Array:
	var length = array.size()
	var new_length = round(length * reduction)
	var step = round(length / new_length)
	#new_length = snappedi(length,step)
	var new_array = []
	for index in range(0,length,step):
		new_array.append(array[index])
	return array