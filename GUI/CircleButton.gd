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
	draw_circle(Vector2(75,75), 65, Color("#FFFFFF"))
	
	#var rect = Rect2(25,25,100,100)
	#draw_rect(rect, Color("#FFFFFF"))
