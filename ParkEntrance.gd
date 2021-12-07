extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ParkLabel.push_color(Color("000000"))
	$ParkLabel.add_text("ShapeLand")
	$ParkLabel.pop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	var rect = Rect2(-32,0,16,64)
	draw_rect(rect, Color("#FFFFFF"))
	
	rect = Rect2(32,0,16,64)
	draw_rect(rect, Color("#FFFFFF"))
	
	rect = Rect2(-32,-32,80,32)
	draw_rect(rect, Color("#FFFFFF"))
	


	#var df = BitmapFont.new()
	#df.font_data = load("res://Fonts/OpenSans-Regular.ttf")
	#df.size = 120
	#draw_string(load("res://Fonts/OpenSans-Regular.ttf"),Vector2(-128,0),"ShapeLand",Color("FFFFFF"))
