extends Node2D
class_name Ride

export var is_activity = false
export var capacity = 2
var popularity = 0

var riding = []
var queue = []


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func addToQueue(dot):
	queue.push_front(dot)
	
func startRiding():
	if(queue.size() >= 1):
		for i in queue.size():
			if(i == capacity):
				break
			var dot = queue.pop_back()
			dot.hide()
			riding.append(dot)
		
func releaseRiders():
	print("riding_size: " + str(riding.size()))
	while (riding.size() > 0):
		var dot = riding.pop_back()
		dot.releaseFromRide($exitPosition.global_position)
		dot.show()


func _on_ServiceRateTimer_timeout():
	releaseRiders()
	startRiding()
