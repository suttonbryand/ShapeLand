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
	add_child(dot)
	dot.position = $DotStart.position
	current_dots += 1

func _process(delta):
	
	if(placing_ride != null):
		placing_ride.global_position.x = get_global_mouse_position().x
		placing_ride.global_position.y = get_global_mouse_position().y
		
	if(Input.is_action_just_pressed("lm_click") && !in_button_selection && placing_ride != null):
		#print("Consumed at process")
		match(placing_ride_type):
			ride_types.RIDE:
				GlobalSettings.rides.append(placing_ride)
			ride_types.ACTIVITY:
				GlobalSettings.activities.append(placing_ride)
		placing_ride = null
		
	GlobalSettings.time += delta * GlobalSettings.time_multiplier
		
		
func _on_DotSpawnTimer_timeout():
	#print("dot spawner")
	if(current_dots < dot_limit):
		create_dot()

func general_ride_button_press(pscene : String):
	if(placing_ride == null):
		placing_ride = load(pscene).instance() as Ride
		add_child(placing_ride)
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
	
func _on_GiftShopButton_pressed():
	activity_button_press("res://Rides/GiftShop.tscn")
	
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

func _on_ClockTimer_timeout():
	#time += 1 * time_multiplier
	pass


func _on_PauseButton_pressed():
	if(GlobalSettings.time_multiplier == 0):
		GlobalSettings.time_multiplier = 1
	else:
		GlobalSettings.time_multiplier = 0
	updateTimers()


func _on_FFButton_pressed():
	if(GlobalSettings.time_multiplier == 0 || GlobalSettings.time_multiplier == 8):
		GlobalSettings.time_multiplier = 1
	else:
		GlobalSettings.time_multiplier *= 2
	updateTimers()
		
func updateTimers():
	$DotSpawnTimer.update_wait_time()
	for r in GlobalSettings.rides:
		r.get_node("ServiceRateTimer").update_wait_time()
	for a in GlobalSettings.activities:
		a.get_node("ServiceRateTimer").update_wait_time()
	
