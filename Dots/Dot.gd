extends Node2D
class_name Dot

enum States {PAUSED, ENTERING_PARK, CHOOSING_RIDE, MOVING_TO_RIDE, MOVING_TO_RIDE_NO_FP,
GOING_TO_HUB, IN_QUEUE, RIDING, LEAVING_RIDE, LEAVING_PARK, GOING_TO_FASTPASS, REDEEMING_FASTPASS}
var state = States.PAUSED
var destination_attraction
var main_parent
var color : String = "FFFFFF"
var balking_point  : int = 120
var fast_pass_check_point : int = 30

export var ride_preference_weight = 50
export var stay_length = 420

var arrival_time = 0
var leave_time

var fast_pass_ride
var fast_pass_time = -1

func _ready():
	
	$DotName.text = get_class().replace("_"," ")
	
	if(GlobalSettings.debug):
		print("Spawning: " + get_class())
	
	move_to_park()
	pass
	
func _process(delta):
	var velocity = Vector2()
	
	match state:
		States.ENTERING_PARK:
			if(!GlobalSettings.park_open || end_of_stay()):
				state = States.LEAVING_PARK
			else:
				if(position.y <= GlobalSettings.parkEnteredPosition.position.y):
					state = States.CHOOSING_RIDE
				else:
					velocity.y -= GlobalSettings.dot_speed * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index]
			
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
			
			#First check fast pass
			if(fast_pass_time > -1 && fast_pass_ride != null && GlobalSettings.time >= fast_pass_time - fast_pass_ride.getServiceTime()):
				state = States.REDEEMING_FASTPASS
				no_rides_to_look_at = true
			
			# No Rides and No Activities
			elif(rides.size() == 0 && activities.size() == 0):
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
				if(destination_attraction == fast_pass_ride || 
					GlobalSettings.time + destination_attraction.getTotalTime() >= leave_time ||
					(fast_pass_time > -1 && GlobalSettings.time + destination_attraction.getTotalTime() > fast_pass_time)):
					state = States.CHOOSING_RIDE
				else:
					state = States.MOVING_TO_RIDE

		States.MOVING_TO_RIDE, States.MOVING_TO_RIDE_NO_FP:
			if(!GlobalSettings.park_open || end_of_stay()):
				state = States.LEAVING_PARK
			else:
				var ride_enter = destination_attraction.get_node("EntrancePosition").global_position
				position = position.move_toward(ride_enter, delta * 100 * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index])
				if(position.x == ride_enter.x && position.y == ride_enter.y):
					if(state == States.MOVING_TO_RIDE):
						if(destination_attraction.getQueueTime() >= fast_pass_check_point &&
						destination_attraction.fast_pass_installed && fast_pass_ride == null):
							state = States.GOING_TO_FASTPASS
						elif(destination_attraction.getQueueTime() >= balking_point):
							state = States.GOING_TO_HUB
						else:
							state = States.IN_QUEUE
							destination_attraction.addToQueue(self)
					elif(state == States.MOVING_TO_RIDE_NO_FP):
						if(destination_attraction.getQueueTime() >= balking_point):
							state = States.GOING_TO_HUB
						else:
							state = States.IN_QUEUE
							destination_attraction.addToQueue(self)
							
		States.GOING_TO_FASTPASS:
			var fp_location = destination_attraction.getFastPassKioskGlobalPosition()
			position = position.move_toward(fp_location, delta * 100 * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index])
			if(position.x == fp_location.x && position.y == fp_location.y):
				state = States.GOING_TO_HUB if look_for_fast_pass(destination_attraction) else States.MOVING_TO_RIDE_NO_FP
		States.REDEEMING_FASTPASS:
			var fpq_location = fast_pass_ride.getFastPassQueueGlobalPosition()
			position = position.move_toward(fpq_location, delta * 100 * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index])
			if(position.x == fpq_location.x && position.y == fpq_location.y):
				if(fast_pass_ride.redeemFastPass(fast_pass_time,self)):
					print("valid fast pass")
					fast_pass_ride.addToFastPassQueue(self)
					fast_pass_ride = null
					fast_pass_time = -1
					state = States.IN_QUEUE
				else:
					print("invalid fast pass")
					fast_pass_ride = null
					fast_pass_time = -1
					state = States.GOING_TO_HUB
		States.GOING_TO_HUB:
			if(!GlobalSettings.park_open || end_of_stay()):
				state = States.LEAVING_PARK
			else:
				var park_enter_position = GlobalSettings.parkEnteredPosition.global_position
				if(position.x == park_enter_position.x && position.y == park_enter_position.y):
					state = States.CHOOSING_RIDE
				position = position.move_toward(park_enter_position, delta * GlobalSettings.dot_speed * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index])
		States.LEAVING_PARK:
			var dot_spawn_position = GlobalSettings.dotSpawnedPosition.global_position
			position = position.move_toward(dot_spawn_position, delta * GlobalSettings.dot_speed * GlobalSettings.time_multipliers[GlobalSettings.time_multiplier_index])
			if(position.x == dot_spawn_position.x  && position.y == dot_spawn_position.y):
				get_parent().remove_child(self)
				queue_free()
				
	position += velocity * delta

func releaseFromRide(release_position):
	position.x = release_position.x
	position.y = release_position.y
	state = States.GOING_TO_HUB
	
func _draw():
	draw_dot()
	
func draw_dot():
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
	arrival_time = GlobalSettings.time
	leave_time = arrival_time + stay_length
	
func end_of_stay():
	return GlobalSettings.time >= leave_time

func change_parent(new_parent : Node2D):
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
		
func look_for_fast_pass(var ride):
	var fp_time = ride.lookForFastPass(self)
	print("got fp_time: " + str(fp_time))
	if(fp_time > 0):
		fast_pass_time = fp_time
		fast_pass_ride = ride
		return true
	return false
		
func get_class():
	return "Dot"
	
func _on_Area2D_area_entered(area):
	area.get_parent().stop_following()


func _on_Area2D2_mouse_entered():
	$DotName.visible = true


func _on_Area2D2_mouse_exited():
	$DotName.visible = false
