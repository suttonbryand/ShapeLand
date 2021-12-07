extends Button


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
	vector_array.append(Vector2(32,8))
	vector_array.append(Vector2(48,24))
	vector_array.append(Vector2(16,24))
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	draw_polygon(vector_array,color_array)
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(32,16))
	vector_array.append(Vector2(56,40))
	vector_array.append(Vector2(8,40))
	color_array = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	draw_polygon(vector_array,color_array)
	
	vector_array = PoolVector2Array()
	vector_array.append(Vector2(32,32))
	vector_array.append(Vector2(64,56))
	vector_array.append(Vector2(0,56))
	color_array = PoolColorArray()
	color_array.append(Color("FFFFFF"))
	draw_polygon(vector_array,color_array)
	
