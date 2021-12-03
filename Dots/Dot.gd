extends Node2D
class_name Dot

enum States {ENTERING_PARK, CHOOSING_RIDE, MOVING_TO_RIDE, GOING_TO_HUB, IN_QUEUE}
var state = States.ENTERING_PARK
var destination_attraction : Ride

export var ride_preference_weight = 50

func _ready():
	move_to_park()
	pass
	
func _process(delta):
	var velocity = Vector2()
	
	match state:
		States.ENTERING_PARK:
			
			if(position.y <= self.get_parent().get_node("ParkEntered").position.y):
				state = States.CHOOSING_RIDE
			else:
				velocity.y -= 100
			
		States.CHOOSING_RIDE:
			
			#Coin Flip
				# 0 - Ride
				# 1 - Attractions
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var act_plan = rng.randi_range(0,100)
			var rides = self.get_parent().rides
			var activities = self.get_parent().activities
			var no_rides_to_look_at : bool = false
			
			# No Rides and No Activities
			if(rides.size() == 0 && activities.size() == 0):
				no_rides_to_look_at = true
			# Rides but No Activities. Put all weight towards rides
			elif(activities.size() == 0):
				ride_preference_weight = 101
			#Activites but no Rides
			elif(rides.size() == 0):
				ride_preference_weight = -1
			
			if(!no_rides_to_look_at):
				if (act_plan <= ride_preference_weight):
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
			var ride_enter = destination_attraction.get_node("entrancePosition").global_position
			position = position.move_toward(ride_enter, delta * 100)
			if(position.x == ride_enter.x && position.y == ride_enter.y):
				destination_attraction.addToQueue(self)
				state = States.IN_QUEUE
		States.GOING_TO_HUB:
			var park_enter_position = self.get_parent().get_node("ParkEntered").global_position
			if(position.x == park_enter_position.x && position.y == park_enter_position.y):
				state = States.CHOOSING_RIDE
			position = position.move_toward(park_enter_position, delta * 100)
		
	position += velocity * delta

func releaseFromRide(release_position):
	position.x = release_position.x
	position.y = release_position.y
	state = States.GOING_TO_HUB
	
func _draw():
	draw_circle(Vector2(0,0), 10, Color("#FFFFFF"))
	
func move_to_park():
	state = States.ENTERING_PARK
	
	
