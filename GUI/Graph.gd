extends Node2D

const pixels_x = 640
const pixels_y = 384

var max_x = pixels_x
var max_y = pixels_y

var plots = []


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func draw_graph():
	var x_point : float = pixels_x / max_x as float
	var y_point : float = pixels_y / max_y as float
	
	print(str(x_point))
	print(str(y_point))
	
	var prev_vector = Vector2(64,448)
	for plot in plots:
		var x_plot = 64 + (plot[0] * x_point)
		var y_plot = 448 - (plot[1] * y_point)
		var new_vector = Vector2(x_plot,y_plot)
		draw_line(prev_vector,new_vector,Color("FFFFFF"),4)
		prev_vector = new_vector
		print(x_plot)
		print(y_plot)
	
# plots_add = [ [x value, y value],...]
func add_plots(plots_add):
	plots += plots_add
	
func clear_plots():
	plots = []
	update()

func _draw():
	draw_line(Vector2(64,64),Vector2(64,448),Color("FFFFFF"),8)
	draw_line(Vector2(64,448),Vector2(704,448),Color("FFFFFF"),8)
	
	var i = 128
	while(i <= 704):
		draw_line(Vector2(i,64),Vector2(i,448),Color("FFFFFF"),1)
		i += 64
		
	i = 64
	while(i < 448):
		draw_line(Vector2(64,i),Vector2(704,i),Color("FFFFFF"),1)
		i += 64
		
	draw_graph()
	
