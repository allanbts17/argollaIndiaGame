@tool
extends Sprite2D

@export_enum("Rojo", "Azul", "Verde","Neutro") var color := 3: set = set_property, get = get_property
#var selected_option: set = _set_selected_option, get = getOP


func _ready():
	if Engine.is_editor_hint():
		#set_property()
		pass
			

func set_property(_color):
	print(_color)
	color = _color
	if _color == 0:
		modulate = Color("ff0004")
	elif _color == 1:
		modulate = Color("3300ff")
	elif _color == 2:
		modulate = Color("00ff39")
	elif _color == 3:
		modulate = Color("ffffff")
	
func get_property():
	return color
