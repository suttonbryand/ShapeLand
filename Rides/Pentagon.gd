extends Ride
class_name Pentagon


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	popularity = 35


func _draw():
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(128,32))
	vector_array.append(Vector2(240,112))
	vector_array.append(Vector2(200,216))
	vector_array.append(Vector2(56,216))
	vector_array.append(Vector2(16,104))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	
	draw_polygon(vector_array,color_array)
	
func get_class():
	return "Pentagon"
