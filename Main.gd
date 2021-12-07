extends Node2D

export var dot_limit = 100
var current_dots = 0

enum ride_types {RIDE, ACTIVITY}

var placing_ride : Ride
var placing_ride_type

var in_button_selection = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSettings.parkEnteredPosition = $ParkEntered
	GlobalSettings.dotSpawnedPosition = $DotStart
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_dot():
	var archetypes = [
		"RideEnthusiast", 
		"RideFan", 
		"AverageTourist", 
		"ActivityFan", 
		"AnnualPassholder",
		"EntitledAnnualPassholder",
		"Vlogger" ]

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var arch_index = rng.randi_range(0,6)
	var dot = load("res://Dots/" + archetypes[arch_index] + ".tscn").instance()
	match current_dots:
		0:
			dot.color = "FF0000"
		1:
			dot.color = "00FF00"
		2:
			dot.color = "0000FF"	
		_:
			dot.color = "FFFFFF"
	$ParkContainer.add_child(dot)
	GlobalSettings.dots.append(dot)
	dot.position = $DotStart.position
	current_dots += 1

func _process(delta):
	
	if(placing_ride != null):
		placing_ride.global_position.x = get_global_mouse_position().x - GlobalSettings.ride_center_x
		placing_ride.global_position.y = get_global_mouse_position().y - GlobalSettings.ride_center_y
		
	if(Input.is_action_just_pressed("lm_click") && !in_button_selection && placing_ride != null):
		#print("Consumed at process")
		match(placing_ride_type):
			ride_types.RIDE:
				GlobalSettings.rides.append(placing_ride)
			ride_types.ACTIVITY:
				GlobalSettings.activities.append(placing_ride)
		GlobalSettings.money -= placing_ride.cost
		placing_ride = null
		
	GlobalSettings.time += delta * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index]
	
	if(GlobalSettings.park_open && int(GlobalSettings.time) >= 60):
		print("closing park")
		GlobalSettings.park_open = false
		$DotSpawnTimer.stop()
		$StatCollector.stop()
		for r in GlobalSettings.rides:
			r.closeRide()
		for a in GlobalSettings.activities:
			a.closeRide()
		$MainCamera/MainCameraLayer/CloseParkPrompt.visible = true
		
func _on_DotSpawnTimer_timeout():
	#print("dot spawner")
	if(current_dots < dot_limit):
		create_dot()
	#$DotSpawnTimer.restore_full_wait_time()

func general_ride_button_press(pscene : String):
	if(placing_ride == null):
		placing_ride = load(pscene).instance() as Ride
		$ParkContainer.add_child(placing_ride)
	else:
		placing_ride.queue_free()
		placing_ride = null
			
func ride_button_press(pscene : String):
	placing_ride_type = ride_types.RIDE
	general_ride_button_press(pscene)
	
func activity_button_press(pscene: String):
	placing_ride_type = ride_types.ACTIVITY
	general_ride_button_press(pscene)
	
func _on_SquareButton_pressed():
	ride_button_press("res://Rides/Square.tscn")

func _on_CircleButton_pressed():
	ride_button_press("res://Rides/Circle.tscn")
	
func _on_TriangleButton_pressed():
	ride_button_press("res://Rides/Triangle.tscn")
	
func _on_PentagonButton_pressed():
	ride_button_press("res://Rides/Pentagon.tscn")
	
func _on_HexagonButton_pressed():
	ride_button_press("res://Rides/Hexagon.tscn")
	
func _on_SeptagonButton_pressed():
	ride_button_press("res://Rides/Septagon.tscn")
	
func _on_TrapezoidButton_pressed():
	ride_button_press("res://Rides/Trapezoid.tscn")
	
func _on_OvalButton_pressed():
	ride_button_press("res://Rides/Oval.tscn")
	
func _on_RectangleButtons_pressed():
	ride_button_press("res://Rides/Rectangle.tscn")
	
func _on_OctagonButton_pressed():
	ride_button_press("res://Rides/Octagon.tscn")
	
func _on_GiftShopButton_pressed():
	activity_button_press("res://Rides/GiftShop.tscn")
	
func _on_RestaurantButton_pressed():
	activity_button_press("res://Rides/Restaurant.tscn")
	
func _on_ChristmasTreeButton_pressed():
	activity_button_press("res://Rides/ChristmasTree/ChristmasTree.tscn")
	
func _on_SantaButton_pressed():
	activity_button_press("res://Rides/Santa.tscn")
	

	
func _on_ButtonSelection_mouse_entered():
	in_button_selection = true

func _on_ButtonSelection_mouse_exited():
	in_button_selection = false


func _on_SquareButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_SquareButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_CircleButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_CircleButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_GiftShopButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_GiftShopButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_TriangleButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_TriangleButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_PentagonButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_PentagonButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_HexagonButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_HexagonButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_SeptagonButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_SeptagonButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_TrapezoidButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_TrapezoidButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_OvalButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_OvalButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_RectangleButtons_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_RectangleButtons_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_OctagonButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_OctagonButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_ChristmasTreeButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_ChristmasTreeButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_RestaurantButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()	
func _on_RestaurantButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()
func _on_SantaButton_mouse_entered():
	self._on_ButtonSelection_mouse_entered()
func _on_SantaButton_mouse_exited():
	self._on_ButtonSelection_mouse_exited()


	
func _on_ClockTimer_timeout():
	#time += 1 * time_multiplier
	pass


func _on_PauseButton_pressed():
	if(GlobalSettings.time_multiplier_index == 0):
		GlobalSettings.time_multiplier_index = 1
	else:
		GlobalSettings.time_multiplier_index = 0
	updateTimers()


func _on_FFButton_pressed():
	if(GlobalSettings.time_multiplier_index == GlobalSettings.time_multipliers.size() - 1):
		GlobalSettings.time_multiplier_index = 1
	else:
		GlobalSettings.time_multiplier_index += 1
	updateTimers()
		
func updateTimers():
	$DotSpawnTimer.update_wait_time()
	$StatCollector.update_wait_time()
	for r in GlobalSettings.rides:
		r.get_node("ServiceRateTimer").update_wait_time()
		r.get_node("ReleaseQueueTimer").update_wait_time()
	for a in GlobalSettings.activities:
		a.get_node("ServiceRateTimer").update_wait_time()
		a.get_node("ReleaseQueueTimer").update_wait_time()
	

func _on_StatCollector_timeout():
	#collect average queue times
	var total_queue_time = 0
	for ride in GlobalSettings.rides:
		total_queue_time += ride.getQueueTime()
	var avg_queue_time = 0
	if(GlobalSettings.rides.size() > 0):
		avg_queue_time = total_queue_time / GlobalSettings.rides.size()
		GlobalSettings.avg_queue_times.append(avg_queue_time)
	else:
		GlobalSettings.avg_queue_times.append(0)
		
	#Get Time
	#Y is avg queu time
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.max_x = 540
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.max_y = 180
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.add_plots([[int(GlobalSettings.time),avg_queue_time]])
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.update()
	var aqt = "AvgQueueTimes:: "
	for t in GlobalSettings.avg_queue_times:
		aqt += str(t) + ".."
	#$StatCollector.restore_full_wait_time()
	


func _on_ContinueButton_pressed():
	$MainCamera/MainCameraLayer/CloseParkPrompt.visible = false
	GlobalSettings.time = 0.00
	GlobalSettings.day += 1
	current_dots = 0
	GlobalSettings.park_open = true
	$DotSpawnTimer.start()
	$StatCollector.start()
	for r in GlobalSettings.rides:
		r.openRide()
	for a in GlobalSettings.activities:
		a.openRide()
