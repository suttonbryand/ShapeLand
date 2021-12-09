extends Activity
class_name Santa

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var rect = Rect2(100,88,56,56)
	draw_rect(rect, Color("#404040"))
	
	rect = Rect2(88,136,80,56)
	draw_rect(rect, Color("#404040"))
	
	draw_circle(Vector2(128,128), 8, Color("#FFFFFF"))
	
	draw_circle(Vector2(168,176), 8, Color("#FFFFFF"))
	
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(128,101))
	vector_array.append(Vector2(136,124))
	vector_array.append(Vector2(120,124))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FF0000"))
	
	draw_polygon(vector_array,color_array)
	
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(168,148))
	vector_array.append(Vector2(176,172))
	vector_array.append(Vector2(160,172))
	
	color_array = PoolColorArray()
	color_array.append(Color("00FF00"))
	
	draw_polygon(vector_array,color_array)
	
	draw_circle(Vector2(128,101), 2, Color("#FFFFFF"))
	
	draw_circle(Vector2(168,148), 2, Color("#FFFFFF"))
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(120,128))
	vector_array.append(Vector2(136,128))
	vector_array.append(Vector2(128,144))
	
	color_array = PoolColorArray()
	color_array.append(Color("b0b0b0"))
	
	draw_polygon(vector_array,color_array)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_class():
	return "Santa"
