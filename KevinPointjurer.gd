extends Dot
class_name Kevin_Pointjurer

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
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(-8,-32))
	vector_array.append(Vector2(-8,-24))
	vector_array.append(Vector2(16,-24))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("858585"))
	
	draw_polygon(vector_array,color_array)	
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(-8,0))
	vector_array.append(Vector2(-8,-8))
	vector_array.append(Vector2(16,-8))
	
	color_array = PoolColorArray()
	color_array.append(Color("858585"))
	
	draw_polygon(vector_array,color_array)	
	
	var rect = Rect2(-8,-24,8,16)
	draw_rect(rect, Color("#858585"))
	
	rect = Rect2(8,-24,8,16)
	draw_rect(rect, Color("#858585"))
	
func get_class():
	return "Kevin_Pointjurer"
