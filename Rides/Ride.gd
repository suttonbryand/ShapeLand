extends Node2D
class_name Ride

export var is_activity : bool = false
export var capacity : int = 2
export var cost : int = 50000
var popularity : int = 0

var riding = []
var queue = []
var release_queue = []

var arrivals : int = 0
var arrival_rate : float = 0.00




# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	popReleaseQueue()

func addToQueue(dot):
	var queue_path_follow = QueuePathFollow.new()
	queue_path_follow.current_queue_size = queue.size()
	queue.push_back(dot)
	$QueuePath.add_child(queue_path_follow)
	dot.change_parent(queue_path_follow)
	dot.global_position.x = $EntrancePosition.global_position.x
	dot.global_position.y = $EntrancePosition.global_position.y
	queue_path_follow.loop = false
	queue_path_follow.start_following = true
	arrivals += 1
	
func startRiding():
	while(queue.size() > 0 && riding.size() < capacity):
		var dot = queue.pop_front()
		dot.hide()
		dot.state = dot.States.RIDING
		riding.append(dot)
		#$ServiceRateTimer.wait_time = 4096
		
	for waiter in queue:
		waiter.move_in_line(riding.size())
		
func releaseRiders():
	while (riding.size() > 0):
		var dot = riding.pop_back()
		dot.state = dot.States.LEAVING_RIDE
		release_queue.push_back(dot)
		
func popReleaseQueue():
		if(release_queue.size() > 0):
			var dot = release_queue.pop_front()
			dot.restore_main_parent()
			dot.releaseFromRide($ExitPosition.global_position)
			dot.show()
		
func getQueueTime():
	return int((queue.size() / capacity) * ($ServiceRateTimer.wait_time * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index]))

func openRide():
	$ServiceRateTimer.start()
	$ReleaseQueueTimer.start()

func closeRide():
	$ServiceRateTimer.stop()
	$ReleaseQueueTimer.stop()
	closeQueue()
	while(release_queue.size() > 0):
		popReleaseQueue()
	releaseRiders()
	while(release_queue.size() > 0):
		popReleaseQueue()
	
func closeQueue():
	while(queue.size() > 0):
		var dot = queue.pop_front()
		if(!GlobalSettings.park_open):
			dot.restore_main_parent()
			dot.state = dot.States.LEAVING_PARK

func _on_ServiceRateTimer_timeout():
	releaseRiders()
	startRiding()


func _on_ArrivalRateTimer_timeout():
	if(arrivals > 0):
		arrival_rate = arrivals / $ArrivalRateTimer.wait_time
		#print("Arrival Rate for " + str(self.get_class()) + ": " + str(arrival_rate))
		arrivals = 0


func _on_ReleaseQueueTimer_timeout():
	popReleaseQueue()
