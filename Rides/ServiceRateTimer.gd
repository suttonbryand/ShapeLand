extends AbstractTimer
class_name ServiceRateTimer
var cter = 0

func _process(delta):
	if(false):
		cter += delta
		if(int(cter) % 5 == 0):
			print("WAIT TIME: " + str(wait_time))
			cter = 0
