extends Ride
class_name Septagon

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	popularity = 30


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(128,32))
	vector_array.append(Vector2(216,64))
	vector_array.append(Vector2(248,136))
	vector_array.append(Vector2(192,208))
	vector_array.append(Vector2(64,208))
	vector_array.append(Vector2(8,136))
	vector_array.append(Vector2(40,64))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	
	draw_polygon(vector_array,color_array)
	
func get_class():
	return "Septagon"
