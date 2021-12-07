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
	draw_circle(Vector2(16,32), 16, Color("#FFFFFF"))
	draw_circle(Vector2(48,32), 16, Color("#FFFFFF"))
	var rect = Rect2(16,16,32,32)
	draw_rect(rect, Color("#FFFFFF"))
