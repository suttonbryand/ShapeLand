extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	self.position.x += ((Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * delta * 1000)
	self.position.y += ((Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * delta * 1000)
