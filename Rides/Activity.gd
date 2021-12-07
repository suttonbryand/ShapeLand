extends Ride
class_name Activity

export var charge : int = 100


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	capacity = 10
	$ServiceRateTimer.wait_time = 1
	$ReleaseQueueTimer.wait_time = .1
	
	var old_qp = $QueuePath
	remove_child(old_qp)
	old_qp.queue_free()
	$QueuePath_small/QueuePathFollow.total_length = 380
	$QueuePath_small.name = "QueuePath"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func addToQueue(dot):
	GlobalSettings.money += charge
	.addToQueue(dot)
