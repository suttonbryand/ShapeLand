extends Dot
class_name Vlogger

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Vlogger")
	ride_preference_weight = 65
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	draw_circle(Vector2(4,-12),8,Color("b0b0b0"))
	draw_line(Vector2(9,-4),Vector2(-14,-14),Color("b0b0b0"),6)
	draw_line(Vector2(0,4),Vector2(-24,0),Color("b0b0b0"),2)
	draw_line(Vector2(-28,4),Vector2(-20,-4),Color("b0b0b0"),6)
	draw_line(Vector2(-27,3),Vector2(-21,-3),Color("858585"),4)
