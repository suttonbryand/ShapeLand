extends Node

const dot_speed : int = 100

var time_multiplier : int = 1.00

var time : float = 0.00

var parkEnteredPosition : Position2D = Position2D.new()

var rides = []
var activities = []

var dot_count : int = 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func format_time():
	var calc_time : int = int(time)
	var hours : int = int(calc_time / 60)
	calc_time -= (hours * 60)
	
	var hour_str : String = str(hours) if hours >= 10 else "0" + str(hours)
	var minute_str : String = str(calc_time) if calc_time >= 10 else "0" + str(calc_time)
	
	return hour_str + ":" + minute_str
