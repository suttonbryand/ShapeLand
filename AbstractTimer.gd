extends Timer
class_name AbstractTimer
var wait_time_hold = wait_time


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass
	
func update_wait_time():
	var multiplier = GlobalSettings.time_multiplier
	if(multiplier == 0):
		paused = true
	else:
		paused = false
		wait_time = wait_time_hold / multiplier
	pass
