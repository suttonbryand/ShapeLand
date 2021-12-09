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

var info_entered = false
var info_enabled = false

var fast_pass_installed = false
var fast_pass_reservation = {}
var fast_pass_queue = []
var fast_pass_latest_reserved_time = -1



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	popReleaseQueue()

func _ready():
	$GraphCanvasLayer/GraphMenu/QueueGraph.max_x = 540
	$GraphCanvasLayer/GraphMenu/QueueGraph.max_y = 180

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
	
func addToFastPassQueue(dot):
	fast_pass_queue.push_back(dot)
	
func startRiding():
	pullFromQueue(fast_pass_queue, int(capacity / 2))
	var pulled_from_queue : int = pullFromQueue()
		
	for waiter in queue:
		waiter.move_in_line(pulled_from_queue)
		
func pullFromQueue(queue_arg = queue, capacity_arg = capacity):
	var pulled : int = 0
	while(queue_arg.size() > 0 && riding.size() < capacity_arg):
		var dot = queue_arg.pop_front()
		dot.hide()
		dot.state = dot.States.RIDING
		riding.append(dot)
		pulled += 1
		#$ServiceRateTimer.wait_time = 4096	
	return pulled
		
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
		
func getQueueTime(update_graph = false):
	var queue_time = int(((queue.size() + fast_pass_queue.size()) / capacity) * getServiceTime())
	if(update_graph):
		$GraphCanvasLayer/GraphMenu/QueueGraph.add_plots([[GlobalSettings.time,queue_time]])
		$GraphCanvasLayer/GraphMenu/QueueGraph.update()
	return queue_time

func getServiceTime():
	return $ServiceRateTimer.wait_time_real
	
func getTotalTime():
	return getQueueTime() + getServiceTime()
	
func lookForFastPass(var dot):
	var start_look_time = GlobalSettings.time + getTotalTime()
	if(fast_pass_latest_reserved_time + getServiceTime() > start_look_time):
		start_look_time = fast_pass_latest_reserved_time + getServiceTime()
	var found_fast_pass = false
	while(!found_fast_pass && start_look_time < dot.leave_time):
		if(!fast_pass_reservation.has(start_look_time)):
			fast_pass_reservation[start_look_time] = dot
			found_fast_pass = true
		else:
			start_look_time += getServiceTime()
	fast_pass_latest_reserved_time = start_look_time
	return start_look_time if found_fast_pass else -1
	
func redeemFastPass(var fp_time, var dot):
	print("redeeming with fp_time " + str(fp_time))
	if (fast_pass_reservation.has(fp_time) && fast_pass_reservation[fp_time] == dot):
		fast_pass_reservation.erase(fp_time)
		return true
	return false
	
func getFastPassKioskGlobalPosition():
	return $FastPassKiosk.global_position
	
func getFastPassQueueGlobalPosition():
	return $FastPassQueue.global_position
		
	
func clearQueueTimes():
	$GraphCanvasLayer/GraphMenu/QueueGraph.clear_plots()
	
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

func place_ride():
	info_enabled = true
	$RideArea/InfoButton.visible = true

func _on_ReleaseQueueTimer_timeout():
	popReleaseQueue()


func _on_Area2D_mouse_entered():
	pass # Replace with function body.


func _on_RideArea_mouse_entered():
	if(info_enabled):
		$RideArea/InfoButton.visible = true

func _on_RideArea_mouse_exited():
	if(!info_entered):
		$RideArea/InfoButton.visible = false


func _on_InfoButton_pressed():
	$GraphCanvasLayer/GraphMenu.visible = true


func _on_InfoButton_mouse_entered():
	info_entered = true

func _on_InfoButton_mouse_exited():
	info_entered = false


func _on_CloseQueueGraph_pressed():
	$GraphCanvasLayer/GraphMenu.visible = false


func _on_InstallFastPass_pressed():
	$FastPassKiosk.visible = true
	$GraphCanvasLayer/GraphMenu/InstallFastPass.visible = false
	fast_pass_installed = true
