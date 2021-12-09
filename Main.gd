extends Node2D

export var dot_limit_hard_max = 1000
var dot_limit = 100
var current_dots = 0

enum ride_types {RIDE, ACTIVITY}

var placing_ride : Ride
var placing_ride_type

var in_button_selection = false

const arrival_rates = [.05,.15,.23,.18,.20,.10,.05,.02,.02]
var park_entrance_queue = []

var ride_price_colors = {}
var rides_placed_unique = []

const archetypes = [
	"RideEnthusiast", 
	"RideFan", 
	"AverageTourist", 
	"ActivityFan", 
	"AnnualPassholder",
	"EntitledAnnualPassholder",
	"Vlogger",
	"SpecificVlogger" ]

const specific_vloggers = [
	"Dotty_Nicholson",
	"Kevin_Pointjurer",
	"Dotcast_The_Ride",
	"OffDotDisney"
]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("calling ready")
	GlobalSettings.parkEnteredPosition = $ParkEntered
	GlobalSettings.dotSpawnedPosition = $DotStart
	
	_on_DotSpawnTimer_timeout()
	$ParkEntranceQueueTimer.start(.2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_dot():
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var arch_index = rng.randi_range(0,archetypes.size() - 1)
	var archetype = archetypes[arch_index]
	if(archetype == "SpecificVlogger"):
		if(specific_vloggers.size() > 0):
			rng.randomize()
			var specific_vlogger_index = rng.randi_range(0,specific_vloggers.size() - 1)
			archetype = specific_vloggers[specific_vlogger_index]
			specific_vloggers.remove(specific_vlogger_index)
			$MainCamera/MainCameraLayer/TextFeed.add_feed_text(archetype.replace("_"," ") + " has arrived at Shapeland.")
		else:
			archetype = "Vlogger"
	var dot = load("res://Dots/" + archetype + ".tscn").instance()
	return dot

func _process(delta):
	
	if(placing_ride != null):
		placing_ride.global_position.x = get_global_mouse_position().x - GlobalSettings.ride_center_x
		placing_ride.global_position.y = get_global_mouse_position().y - GlobalSettings.ride_center_y
		
	if(Input.is_action_just_pressed("lm_click") && !in_button_selection && placing_ride != null):
		#print("Consumed at process")
		match(placing_ride_type):
			ride_types.RIDE:
				GlobalSettings.rides.append(placing_ride)
				
				if(!rides_placed_unique.has(placing_ride.get_class())):
					dot_limit += placing_ride.popularity * 2
					rides_placed_unique.append(placing_ride.get_class())
					
			ride_types.ACTIVITY:
				GlobalSettings.activities.append(placing_ride)
		GlobalSettings.money -= GlobalSettings.ride_prices.get(placing_ride.get_class())
		placing_ride.place_ride()
		placing_ride = null
	elif(Input.is_action_just_pressed("rm_click") && placing_ride != null):
		placing_ride.queue_free()
		placing_ride = null
		
	if(Input.is_action_just_pressed("ui_esacape")):
		_on_HelpButton_pressed()
		
	GlobalSettings.time += delta * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index]
	
	if(GlobalSettings.park_open && int(GlobalSettings.time) >= (60 * arrival_rates.size() - 1)):
		print("closing park")
		GlobalSettings.park_open = false
		$DotSpawnTimer.stop()
		$StatCollector.stop()
		for r in GlobalSettings.rides:
			r.closeRide()
		for a in GlobalSettings.activities:
			a.closeRide()
		$MainCamera/MainCameraLayer/CloseParkPrompt/TodaysIncome.clear()
		$MainCamera/MainCameraLayer/CloseParkPrompt/TodaysIncome.add_text("Today's income is $" + str(GlobalSettings.income_daily))
		$MainCamera/MainCameraLayer/CloseParkPrompt.visible = true
		
	set_price_colors()
		
func set_price_colors():
	for ride in GlobalSettings.ride_prices.keys():
		var price = GlobalSettings.ride_prices.get(ride)
		var price_label = $MainCamera/MainCameraLayer/ButtonSelection.get_node(ride + "Button").get_node("PriceLabel")
		if(price > GlobalSettings.money):
			if(ride_price_colors.has(ride)):
				if(ride_price_colors[ride] != "FF000"):
					price_label.clear()
					price_label.push_color("FF0000")
					price_label.add_text("$" + str(price))
					ride_price_colors[ride] = "FF0000"
			else:
				price_label.push_color("FF0000")
				price_label.add_text("$" + str(price))
				ride_price_colors[ride] = "FF0000"
				
		else:
			if(ride_price_colors.has(ride)):
				if(ride_price_colors[ride] != "000000"):
					price_label.clear()
					price_label.push_color("000000")
					price_label.add_text("$" + str(price))
					ride_price_colors[ride] = "000000"
			else:
				price_label.push_color("000000")
				price_label.add_text("$" + str(price))
				ride_price_colors[ride] = "000000"


		
func _on_DotSpawnTimer_timeout():
	#print("dot spawner")
	if(current_dots < dot_limit):
		var dot_spawn_amount_index = int(GlobalSettings.time / 60)
		var dot_spawn_amount = int((dot_limit * arrival_rates[dot_spawn_amount_index]) / (60 / $DotSpawnTimer.wait_time_real))
		if(dot_spawn_amount == 0): dot_spawn_amount = 1
		for i in dot_spawn_amount:
			park_entrance_queue.push_back(create_dot())
		$MainCamera/MainCameraLayer/TimeSection/ClockControl/DotCountDisplays.clear()
		$MainCamera/MainCameraLayer/TimeSection/ClockControl/DotCountDisplays.add_text(str((current_dots + dot_spawn_amount)) + " dots")
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
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Square")):
		ride_button_press("res://Rides/Square.tscn")

func _on_CircleButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Circle")):
		ride_button_press("res://Rides/Circle.tscn")
	
func _on_TriangleButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Triangle")):
		ride_button_press("res://Rides/Triangle.tscn")
	
func _on_PentagonButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Pentagon")):
		ride_button_press("res://Rides/Pentagon.tscn")
	
func _on_HexagonButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Hexagon")):
		ride_button_press("res://Rides/Hexagon.tscn")
	
func _on_SeptagonButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Septagon")):
		ride_button_press("res://Rides/Septagon.tscn")
	
func _on_TrapezoidButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Trapezoid")):
		ride_button_press("res://Rides/Trapezoid.tscn")
	
func _on_OvalButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Oval")):
		ride_button_press("res://Rides/Oval.tscn")
	
func _on_RectangleButtons_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Rectangle")):
		ride_button_press("res://Rides/Rectangle.tscn")
	
func _on_OctagonButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Octagon")):
		ride_button_press("res://Rides/Octagon.tscn")
	
func _on_GiftShopButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("GiftShop")):
		activity_button_press("res://Rides/GiftShop.tscn")
	
func _on_RestaurantButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Restaurant")):
		activity_button_press("res://Rides/Restaurant.tscn")
	
func _on_ChristmasTreeButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("ChristmasTree")):
		activity_button_press("res://Rides/ChristmasTree/ChristmasTree.tscn")
	
func _on_SantaButton_pressed():
	if(GlobalSettings.money >= GlobalSettings.ride_prices.get("Santa")):
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
		total_queue_time += ride.getQueueTime(true)
	for activity in GlobalSettings.activities:
		GlobalSettings.income_daily += activity.getIncome(true,true)
	var avg_queue_time = 0
	if(GlobalSettings.rides.size() > 0):
		avg_queue_time = total_queue_time / GlobalSettings.rides.size()
		GlobalSettings.avg_queue_times.append(avg_queue_time)
	else:
		GlobalSettings.avg_queue_times.append(0)
		
	#Queue Graph
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.max_x = 660
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.max_y = 180
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.add_plots([[int(GlobalSettings.time),avg_queue_time]])
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.update()
	
	#Income Graph
	$MainCamera/MainCameraLayer/GraphMenu/IncomeGraph.max_x = 660
	$MainCamera/MainCameraLayer/GraphMenu/IncomeGraph.max_y = 10000
	$MainCamera/MainCameraLayer/GraphMenu/IncomeGraph.add_plots([[int(GlobalSettings.time),GlobalSettings.income]])
	$MainCamera/MainCameraLayer/GraphMenu/IncomeGraph.update()
	GlobalSettings.income = 0
	
	#Arrivals Graph
	$MainCamera/MainCameraLayer/GraphMenu/ArrivalsGraph.max_x = 660
	$MainCamera/MainCameraLayer/GraphMenu/ArrivalsGraph.max_y = 100
	$MainCamera/MainCameraLayer/GraphMenu/ArrivalsGraph.add_plots([[int(GlobalSettings.time),GlobalSettings.arrivals]])
	$MainCamera/MainCameraLayer/GraphMenu/ArrivalsGraph.update()
	GlobalSettings.arrivals = 0


func _on_ContinueButton_pressed():
	$MainCamera/MainCameraLayer/CloseParkPrompt.visible = false
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.clear_plots()
	$MainCamera/MainCameraLayer/GraphMenu/IncomeGraph.clear_plots()
	$MainCamera/MainCameraLayer/GraphMenu/ArrivalsGraph.clear_plots()
	GlobalSettings.time = 0.00
	GlobalSettings.day += 1
	GlobalSettings.arrivals_daily = 0
	GlobalSettings.income_daily = 0
	current_dots = 0
	GlobalSettings.park_open = true
	$DotSpawnTimer.start()
	$StatCollector.start()
	for r in GlobalSettings.rides:
		r.openRide()
		r.clearQueueTimes()
	for a in GlobalSettings.activities:
		a.openRide()


func _on_AverageQueue_pressed():
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.visible = true
	$MainCamera/MainCameraLayer/GraphMenu/IncomeGraph.visible = false
	$MainCamera/MainCameraLayer/GraphMenu/ArrivalsGraph.visible = false

func _on_Income_pressed():
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.visible = false
	$MainCamera/MainCameraLayer/GraphMenu/IncomeGraph.visible = true
	$MainCamera/MainCameraLayer/GraphMenu/ArrivalsGraph.visible = false
	
func _on_ParkArrival_pressed():
	$MainCamera/MainCameraLayer/GraphMenu/QueueGraph.visible = false
	$MainCamera/MainCameraLayer/GraphMenu/IncomeGraph.visible = false
	$MainCamera/MainCameraLayer/GraphMenu/ArrivalsGraph.visible = true

func _on_CloseGraphMenu_pressed():
	$MainCamera/MainCameraLayer/GraphMenu.visible = false


func _on_ParkEntranceQueueTimer_timeout():
	if(park_entrance_queue.size() > 0):
		var dot = park_entrance_queue.pop_front()
		$ParkContainer.add_child(dot)
		dot.main_parent = $ParkContainer
		GlobalSettings.dots.append(dot)
		dot.position = $DotStart.position
		current_dots += 1
		GlobalSettings.arrivals += 1
		GlobalSettings.arrivals_daily += 1
		GlobalSettings.money += 1
		GlobalSettings.income_daily += 1


func _on_HelpButton_pressed():
	toggle_help_menu()
	
func toggle_help_menu():
	$MainCamera/MainCameraLayer/HelpMenu.visible = !$MainCamera/MainCameraLayer/HelpMenu.visible

func _on_OkButton_pressed():
	toggle_help_menu()


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_MuteMusic_pressed():
	$AudioStreamPlayer2D.stream_paused = !$AudioStreamPlayer2D.stream_paused
