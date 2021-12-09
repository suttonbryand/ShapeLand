extends Dot
class_name AverageTourist

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ride_preference_weight = 50
	stay_length = 420
	balking_point = 120


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	draw_circle(Vector2(4,-4),4,Color("b0b0b0"))
	draw_circle(Vector2(-4,-4),4,Color("b0b0b0"))
	
	var rect : Rect2 = Rect2(-8,2,16,10)
	draw_rect(rect,Color("b0b0b0"))
	
	draw_circle(Vector2(0,8),3,Color("404040"))
	
func get_class():
	return "AverageTourist"
