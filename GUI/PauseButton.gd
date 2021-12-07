extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	draw_line(Vector2(20,8),Vector2(20,56), Color("FFFFFF"), 16)
	draw_line(Vector2(44,8),Vector2(44,56), Color("FFFFFF"), 16)
