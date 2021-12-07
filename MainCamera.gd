extends Camera2D

var zoom_min : Vector2 = Vector2(.2,.2)
var zoom_max : Vector2 = Vector2(4,4)
var zoom_speed : Vector2 = Vector2(.2,.2)

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

func _input(event):
	if event is InputEventMouseButton:
		if(event.is_pressed()):
			if(event.button_index == BUTTON_WHEEL_UP):
				if(zoom > zoom_min):
					zoom -= zoom_speed
			if(event.button_index == BUTTON_WHEEL_DOWN):
				if(zoom < zoom_max):
					zoom += zoom_speed
