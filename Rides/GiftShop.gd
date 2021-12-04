extends Activity
class_name GiftShop

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
	
	draw_circle(Vector2(128,128),32,Color("000000"))
	draw_circle(Vector2(128,128),28,Color("FFFFFF"))
	
	var gbrect = Rect2(80,112,96,64)
	draw_rect(gbrect, Color("#000000"))

func get_class():
	return "GiftShop"
