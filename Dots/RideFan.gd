extends Dot
class_name RideFan

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ride_preference_weight = 65
	stay_length = 420
	balking_point = 120
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	#.draw_dot()
	
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(19,-20))
	vector_array.append(Vector2(10,0))
	vector_array.append(Vector2(-2,-10))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("b0b0b0"))
	
	draw_polygon(vector_array,color_array)
	
func get_class():
	return "RideFan"
