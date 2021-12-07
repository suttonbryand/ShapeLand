extends Ride
class_name Oval


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	popularity = 35


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	draw_circle(Vector2(64,128), 55, Color("#FFFFFF"))
	draw_circle(Vector2(192,128), 55, Color("#FFFFFF"))
	var rect = Rect2(64,72,128,112)
	draw_rect(rect, Color("#FFFFFF"))

func get_class():
	return "Oval"
