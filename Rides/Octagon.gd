extends Ride
class_name Octagon

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	popularity = 35


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(80,0))
	vector_array.append(Vector2(176,0))
	vector_array.append(Vector2(256,80))
	vector_array.append(Vector2(256,184))
	vector_array.append(Vector2(176,256))
	vector_array.append(Vector2(80,256))
	vector_array.append(Vector2(0,184))
	vector_array.append(Vector2(0,80))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	
	draw_polygon(vector_array,color_array)
	
func get_class():
	return "Octagon"
