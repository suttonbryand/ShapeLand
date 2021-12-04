extends Dot
class_name RideEnthusiast

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ride Enthusiast")
	ride_preference_weight = 85
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	var shirt_torso : Rect2 = Rect2(-8,2,16,10)
	draw_rect(shirt_torso,Color("b0b0b0"))
	
	var shirt_arms : Rect2 = Rect2(-12,2,24,4)
	draw_rect(shirt_arms,Color("b0b0b0"))
	
	draw_line(Vector2(-6,4),Vector2(-6,10),Color("000000"),2)
	
	draw_circle(Vector2(-3,6),2,Color("000000"))
	draw_circle(Vector2(-1,6),2,Color("000000"))
	
	var vector_array : PoolVector2Array = PoolVector2Array()
	vector_array.append(Vector2(-5,7))
	vector_array.append(Vector2(1,7))
	vector_array.append(Vector2(-2,10))
	
	var color_array : PoolColorArray = PoolColorArray()
	color_array.append(Color("000000"))
	
	draw_polygon(vector_array,color_array)
	
	vector_array  = PoolVector2Array()
	vector_array.append(Vector2(-1,10))
	vector_array.append(Vector2(8,10))
	vector_array.append(Vector2(4,4))
	
	color_array = PoolColorArray()
	color_array.append(Color("000000"))
	
	draw_polygon(vector_array,color_array)
