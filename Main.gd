extends Node2D

export var dot_limit = 10
var current_dots = 0

enum ride_types {RIDE, ACTIVITY}
var rides = []
var activities = []

var placing_ride : Ride
var placing_ride_type

var in_button_selection = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_dot():
	var archetypes = [
		RideEnthusiast, 
		RideFan, 
		AverageTourist, 
		ActivityFan, 
		AnnualPassholder,
		EntitledAnnualPassholder,
		Vlogger ]

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var arch_index = rng.randi_range(0,6)
	var dot : Dot = archetypes[arch_index].new()
	add_child(dot)
	dot.position = $DotStart.position
	current_dots += 1

func _process(delta):
	
	if(placing_ride != null):
		placing_ride.global_position.x = get_global_mouse_position().x
		placing_ride.global_position.y = get_global_mouse_position().y
		
	if(Input.is_action_just_pressed("lm_click") && !in_button_selection && placing_ride != null):
		print("Consumed at process")
		match(placing_ride_type):
			ride_types.RIDE:
				rides.append(placing_ride)
			ride_types.ACTIVITY:
				activities.append(placing_ride)
		placing_ride = null
		
		
func _on_DotSpawnTimer_timeout():
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
