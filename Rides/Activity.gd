extends Ride
class_name Activity

export var charge : int = 100

var income : int = 0


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
	
	$GraphCanvasLayer/GraphMenu/QueueGraph.max_x = 540
	$GraphCanvasLayer/GraphMenu/QueueGraph.max_y = 10000

func getIncome(update_graph = false, reset_income = false):
	var return_income = income
	if(update_graph):
		$GraphCanvasLayer/GraphMenu/QueueGraph.add_plots([[GlobalSettings.time,income]])
		$GraphCanvasLayer/GraphMenu/QueueGraph.update()
	if(reset_income):
		income = 0
	return income
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func addToQueue(dot):
	GlobalSettings.money += charge
	GlobalSettings.income += charge
	GlobalSettings.income_daily += charge
	income += charge
	.addToQueue(dot)
