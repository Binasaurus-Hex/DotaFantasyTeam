extends Timer

class_name PollTimer

signal seconds_changed(seconds)
var seconds: int = 0

func _ready():
	if autostart:
		start()
	connect("timeout", self, "on_timeout")

func _process(delta):
	if floor(time_left) < seconds:
		emit_signal("seconds_changed", seconds)
		seconds -= 1
		
func start(time_sec: float = -1):
	.start(time_sec)
	seconds = round(time_left)
	
func on_timeout():
	seconds = round(time_left)
