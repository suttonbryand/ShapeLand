extends Activity
class_name ChristmasTree


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(128,72))
	vector_array.append(Vector2(152,104))
	vector_array.append(Vector2(104,104))
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	draw_polygon(vector_array,color_array)
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(128,88))
	vector_array.append(Vector2(160,128))
	vector_array.append(Vector2(96,128))
	color_array = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	draw_polygon(vector_array,color_array)
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(128,104))
	vector_array.append(Vector2(168,152))
	vector_array.append(Vector2(88,152))
	color_array = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	draw_polygon(vector_array,color_array)
	
	var rect = Rect2(120,152,16,32)
	draw_rect(rect, Color("#FFFFFF"))

func get_class():
	return "ChristmasTree"


func _on_LightTimer_timeout():
	for light in $TreeLights.get_children():
		light.change_color()
