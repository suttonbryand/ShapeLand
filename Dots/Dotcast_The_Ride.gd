extends Dot
class_name DotCast_The_Ride

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
	draw_circle(Vector2(-16,-8), 10, Color(color))
	draw_circle(Vector2(16,-6), 10, Color(color))
	
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(16,-8))
	vector_array.append(Vector2(24,0))
	vector_array.append(Vector2(8,0))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(-8,-16))
	vector_array.append(Vector2(-8,-8))
	vector_array.append(Vector2(-24,-16))
	
	color_array = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(16,-8))
	vector_array.append(Vector2(24,4))
	vector_array.append(Vector2(8,4))
	
	color_array = PoolColorArray()
	color_array.append(Color("858585"))
	
	draw_polygon(vector_array,color_array)
	
	vector_array  = PoolVector2Array()
	vector_array.append(Vector2(-24,-18))
	vector_array.append(Vector2(-8,-18))
	vector_array.append(Vector2(-8,-10))
	
	color_array = PoolColorArray()
	color_array.append(Color("858585"))
	
	var rect = Rect2(-12,-4,8,8)
	draw_rect(rect, Color("#b0b0b0"))
	
	rect = Rect2(4,-4,8,8)
	draw_rect(rect, Color("#b0b0b0"))
	
	draw_polygon(vector_array,color_array)		
	
func get_class():
	return "DotCast_The_Ride"
