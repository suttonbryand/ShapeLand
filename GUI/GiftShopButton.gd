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
	var rect = Rect2(10,10,44,44)
	draw_rect(rect, Color("#FFFFFF"))
	
	var roof_bottom = Rect2(8,10,48,12)
	draw_rect(roof_bottom, Color("#FFFFFF"))
	
	draw_circle(Vector2(32,32),10,Color("000000"))
	draw_circle(Vector2(32,32),8,Color("FFFFFF"))
	
	var gbrect = Rect2(16,30,32,18)
	draw_rect(gbrect, Color("#000000"))
