extends Ride
class_name Pentagon


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	popularity = 60


func _draw():
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(128,24))
	vector_array.append(Vector2(248,128))
	vector_array.append(Vector2(184,256))
	vector_array.append(Vector2(74,256))
	vector_array.append(Vector2(8,128))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	
	draw_polygon(vector_array,color_array)
	
func get_class():
	return "Pentagon"
