extends Dot
class_name EntitledAnnualPassholder

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ride_preference_weight = 50
	stay_length = 180
	balking_point = 120
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	draw_circle(Vector2(0,0),8,Color("b0b0b0"))
	
func get_class():
	return "EntitledAnnualPassholder"
