extends Activity
class_name Restaurant


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
	var rect = Rect2(64,64,128,128)
	draw_rect(rect, Color("#FFFFFF"))
	
	var roof_bottom = Rect2(50,50,156,32)
	draw_rect(roof_bottom, Color("#FFFFFF"))
	
	rect = Rect2(80,112,36,64)
	draw_rect(rect, Color("#000000"))
	
	rect = Rect2(88,96,4,64)
	draw_rect(rect, Color("#000000"))
	
	rect = Rect2(128,130,56,16)
	draw_rect(rect, Color("#000000"))
	
	rect = Rect2(140,144,32,16)
	draw_rect(rect, Color("#000000"))
	
	rect = Rect2(128,160,56,16)
	draw_rect(rect, Color("#000000"))
	
func get_class():
	return "Restaurant"
