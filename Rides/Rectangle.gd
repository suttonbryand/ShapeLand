extends Ride
class_name Rectangle

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	popularity = 10
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	var rect = Rect2(32,48,192,124)
	draw_rect(rect, Color("#FFFFFF"))
	
func get_class():
	return "Rectangle"
