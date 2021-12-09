extends Dot
class_name OffDotDisney

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ride_preference_weight = 65
	stay_length = 540
	balking_point = 15
	fast_pass_check_point = 15


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():

	var vector_array = PoolVector2Array()
	vector_array.append(Vector2(-16,-16))
	vector_array.append(Vector2(0,-16))
	vector_array.append(Vector2(-16,0))
	
	var color_array = PoolColorArray()
	color_array.append(Color("a38d5d"))

	vector_array = PoolVector2Array()
	vector_array.append(Vector2(-8,-26))
	vector_array.append(Vector2(16,-16))
	vector_array.append(Vector2(16,0))
	
	color_array = PoolColorArray()
	color_array.append(Color("a38d5d"))
	
	draw_polygon(vector_array,color_array)	

func get_class():
	return "OffDotDisney"
