extends Control
class_name SelectionMenu


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("readying SelectionMenu")
	#Draw Square Ride
	var rect = Rect2(0,0,100,100)
	$SelectionPanel/SquareButton.draw_rect(rect, Color("#FFFFFF"))
	$SelectionPanel/SquareButton.update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
