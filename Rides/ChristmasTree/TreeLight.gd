extends Node2D

export var color = "FF0000"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func change_color():
	match color:
		"FF0000":
			color = "00FF00"
			update()
		"00FF00":
			color = "FF0000"
			update()
			
func _draw():
	draw_circle(Vector2(0,0), 4, Color(color))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
