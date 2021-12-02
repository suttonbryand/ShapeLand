extends Node2D

export var dot_limit = 10
var current_dots = 0

var rides = []
var activities = []

var placing_ride : Ride

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
		
	if(Input.is_action_just_pressed("lm_click") && placing_ride != null):
		rides.append(placing_ride)
		placing_ride = null
		
func _on_DotSpawnTimer_timeout():
	if(current_dots < dot_limit):
		create_dot()


func _on_SquareButton_pressed():
	if(placing_ride == null):
		placing_ride = load("res://Rides/Square.tscn").instance() as Square
		add_child(placing_ride)
	else:
		placing_ride.queue_free()
		placing_ride = null
