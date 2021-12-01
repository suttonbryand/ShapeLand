extends Node2D

export var dot_limit = 10
var current_dots = 0

var rides = []
var activities = []

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

func _on_DotSpawnTimer_timeout():
	if(current_dots < dot_limit):
		create_dot()
