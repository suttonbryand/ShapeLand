extends Timer
class_name AbstractTimer
var wait_time_real = wait_time

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if(GlobalSettings.time_multiplier_index != 0):
		start(wait_time / GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index])

func _process(delta):
	pass
	
func update_wait_time():
	
	if(GlobalSettings.time_multiplier_index == 0):
		paused = true
	elif(GlobalSettings.time_multiplier_index == 1):
		paused = false
		var tl = time_left
		stop()
		start(tl * GlobalSettings.time_multipliers[GlobalSettings.time_multipliers.size() - 1])
		wait_time = wait_time_real
	else:
		paused = false
		var tl = time_left
		var wait_time_old = wait_time
		stop()
		start((tl  * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index - 1])
			/ GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index])
		wait_time = ((wait_time_old * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index - 1]) 
			/ GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index])
