extends Node2D
class_name Dot

enum States {ENTERING_PARK, CHOOSING_RIDE, MOVING_TO_RIDE, GOING_TO_HUB, IN_QUEUE}
var state = States.ENTERING_PARK
var destination_attraction : Ride
var main_parent
var color : String = "FFFFFF"

export var ride_preference_weight = 50

func _ready():
	move_to_park()
	pass
	
func _process(delta):
	var velocity = Vector2()
	
	match state:
		States.ENTERING_PARK:
			
			if(position.y <= GlobalSettings.parkEnteredPosition.position.y):
				state = States.CHOOSING_RIDE
			else:
				velocity.y -= GlobalSettings.dot_speed * GlobalSettings.time_multiplier
			
		States.CHOOSING_RIDE:
			
			#Coin Flip
				# 0 - Ride
				# 1 - Attractions
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var act_plan = rng.randi_range(0,100)
			var rides = GlobalSettings.rides
			var activities = GlobalSettings.activities
			var no_rides_to_look_at : bool = false
			var current_ride_preference_weight = ride_preference_weight
			
			# No Rides and No Activities
			if(rides.size() == 0 && activities.size() == 0):
				no_rides_to_look_at = true
			# Rides but No Activities. Put all weight towards rides
			elif(activities.size() == 0):
				current_ride_preference_weight = 101
			#Activites but no Rides
			elif(rides.size() == 0):
				current_ride_preference_weight = -1
			
			if(!no_rides_to_look_at):
				if (act_plan <= current_ride_preference_weight):
					var rides_weighted = []
					for i in range(0,rides.size()):
						var ride = rides[i]
						var popularity = ride.popularity
						for j in range(0,popularity):
							rides_weighted.append(i)
					rng.randomize()
					var ride_selected = rng.randi_range(0,rides_weighted.size() - 1)
					var ride_index_selected = rides_weighted[ride_selected]
					destination_attraction = rides[ride_index_selected]
					#print("Dot wants to ride " + str(ride_index_selected))
				else:
					#print("Dot wants to do activity")
					rng.randomize()
					var chosen_index = rng.randi_range(0,activities.size() - 1)
					destination_attraction = activities[chosen_index]
				state = States.MOVING_TO_RIDE
		States.MOVING_TO_RIDE:
			var ride_enter = destination_attraction.get_node("EntrancePosition").global_position
			position = position.move_toward(ride_enter, delta * 100 * GlobalSettings.time_multiplier)
			if(position.x == ride_enter.x && position.y == ride_enter.y):
				state = States.IN_QUEUE
				destination_attraction.addToQueue(self)
		States.GOING_TO_HUB:
			var park_enter_position = GlobalSettings.parkEnteredPosition.global_position
			if(position.x == park_enter_position.x && position.y == park_enter_position.y):
				state = States.CHOOSING_RIDE
			position = position.move_toward(park_enter_position, delta * GlobalSettings.dot_speed * GlobalSettings.time_multiplier)
		
	position += velocity * delta

func releaseFromRide(release_position):
	position.x = release_position.x
	position.y = release_position.y
	state = States.GOING_TO_HUB
	
func _draw():
	draw_circle(Vector2(0,0), 10, Color(color))
	
func color_word():
	match color:
		"FF0000":
			return "red"
		"00FF00":
			return "green"
		"0000FF":
			return "blue"
		_:
			return "white"
	
func move_to_park():
	state = States.ENTERING_PARK

func change_parent(new_parent : Node2D):
	main_parent = get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)
	
func restore_main_parent():
	get_parent().remove_child(self)
	main_parent.add_child(self)
	
func stop_following():
	if(state == States.IN_QUEUE):
		get_parent().start_following = false
		
func move_in_line(amount : int):
	if(state == States.IN_QUEUE):
		get_parent().move_in_line(amount)
	
func _on_Area2D_area_entered(area):
	print("area entered")
	area.get_parent().stop_following()
