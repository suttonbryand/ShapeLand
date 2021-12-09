extends Dot
class_name AnnualPassholder

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ride_preference_weight = 50
	stay_length = 420
	balking_point = 30
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _draw():
	draw_circle(Vector2(-4,4),4,Color("b0b0b0"))
	
func get_class():
	return "AnnualPassholder"
