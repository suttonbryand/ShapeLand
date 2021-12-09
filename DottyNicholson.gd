extends Dot
class_name Dotty_Nicholson

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ride_preference_weight = 65
	balking_point = 15
	fast_pass_check_point = 15
	stay_length = 540


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(16,-16))
	vector_array.append(Vector2(16,16))
	vector_array.append(Vector2(8,8))
	vector_array.append(Vector2(-8,8))
	vector_array.append(Vector2(-16,16))
	vector_array.append(Vector2(-16,-16))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("#a38d5d"))
	
	draw_polygon(vector_array,color_array)	
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(24,-16))
	vector_array.append(Vector2(16,0))
	vector_array.append(Vector2(8,0))
	
	color_array = PoolColorArray()
	color_array.append(Color("#7992c7"))
	
	draw_polygon(vector_array,color_array)
		
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(-24,-16))
	vector_array.append(Vector2(-8,0))
	vector_array.append(Vector2(-16,0))
	
	color_array = PoolColorArray()
	color_array.append(Color("#7992c7"))
	
	draw_polygon(vector_array,color_array)
	
	draw_circle(Vector2(0,0), 10, Color("FFFFFF"))
	
func get_class():
	return "Dotty_Nicholson"
