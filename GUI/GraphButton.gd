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
	draw_line(Vector2(16,8),Vector2(16,56),Color("FFFFFF"),2)
	draw_line(Vector2(16,56),Vector2(56,56),Color("FFFFFF"),2)
	draw_line(Vector2(16,56),Vector2(24,24),Color("FFFFFF"),1)
	draw_line(Vector2(24,24),Vector2(32,40),Color("FFFFFF"),1)
	draw_line(Vector2(32,40),Vector2(56,8),Color("FFFFFF"),1)
