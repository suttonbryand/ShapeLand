extends Node2D
class_name Ride

export var is_activity = false
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
	pass
	#for i in 6:
	#	var dot : Dot = queue.pop_back()
	#	dot.visible = false
	#	riding.append(queue.pop_back())
		
func releaseRiders():
	pass
	#for i in riding.size():
	#	var dot : Dot = riding.pop_back()
	#	dot.visible = true
	#	dot.releaseFromRide($exitPosition.global_position)


func _on_ServiceRateTimer_timeout():
	#releaseRiders()
	#startRiding()
	pass
