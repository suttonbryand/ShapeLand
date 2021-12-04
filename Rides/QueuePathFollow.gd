extends PathFollow2D
class_name QueuePathFollow

var start_following : bool = false
var total_length = 766
var distance_traveled = 0
var current_queue_size = 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(start_following && distance_traveled < total_length - (current_queue_size * 20)):
		var this_distance = GlobalSettings.dot_speed * GlobalSettings.time_multiplier * delta
		set_offset(get_offset() + this_distance)
		distance_traveled += this_distance
		
func move_in_line(amount : int):
	print("move in line")
	current_queue_size -= 1 * amount
