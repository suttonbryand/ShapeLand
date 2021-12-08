extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var updated = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if(updated):
		var new_text = ""
		for feed in GlobalSettings.text_feed:
			new_text += feed + "\n"
		text = new_text
		updated = false
		
func add_feed_text(text : String):
	updated = true
	if(GlobalSettings.text_feed.size() == 0):
		$FeedPopTimer.start()
	if(GlobalSettings.text_feed.size() > 4):
		GlobalSettings.text_feed.pop_front()
	GlobalSettings.text_feed.push_back(text)


func _on_FeedPopTimer_timeout():
	updated = true
	if(GlobalSettings.text_feed.size() > 0):
		GlobalSettings.text_feed.pop_front()
	else:
		$FeedPopTimer.stop()
