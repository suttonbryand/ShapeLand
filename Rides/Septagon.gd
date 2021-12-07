extends Ride
class_name Septagon

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
	vector_array.append(Vector2(128,0))
	vector_array.append(Vector2(256,96))
	vector_array.append(Vector2(256,168))
	vector_array.append(Vector2(192,230))
	vector_array.append(Vector2(64,230))
	vector_array.append(Vector2(0,168))
	vector_array.append(Vector2(0,96))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	
	draw_polygon(vector_array,color_array)
	
func get_class():
	return "Septagon"
