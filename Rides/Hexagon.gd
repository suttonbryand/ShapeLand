extends Ride
class_name Hexagon


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	popularity = 35
	
func _draw():
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(128,32))
	vector_array.append(Vector2(256,88))
	vector_array.append(Vector2(256,192))
	vector_array.append(Vector2(128,248))
	vector_array.append(Vector2(0,192))
	vector_array.append(Vector2(9,88))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	
	draw_polygon(vector_array,color_array)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_class():
	return "Hexagon"
