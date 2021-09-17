extends ProgressBar

func _process(delta):
	value += 100 * delta
	if value >= 100:
		value = 0
