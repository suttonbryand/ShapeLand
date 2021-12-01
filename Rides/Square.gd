extends Ride
class_name Square

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	popularity = 45
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	var rect = Rect2(0,0,100,100)
	draw_rect(rect, Color("#FFFFFF"))
