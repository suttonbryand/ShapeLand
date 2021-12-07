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
	var rect = Rect2(8,24,16,32)
	draw_rect(rect, Color("#FFFFFF"))
	
	var roof_bottom = Rect2(10,16,4,32)
	draw_rect(roof_bottom, Color("#FFFFFF"))
	
	rect = Rect2(32,16,24,16)
	draw_rect(rect, Color("#FFFFFF"))
	
	rect = Rect2(38,32,12,8)
	draw_rect(rect, Color("#FFFFFF"))
	
	rect = Rect2(32,40,24,16)
	draw_rect(rect, Color("#FFFFFF"))
	
