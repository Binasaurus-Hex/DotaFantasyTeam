extends Control

func _ready():
	pass # TODO initialise the contestants

func _on_Timer_timeout():
	$Tween.interpolate_property(self,"rect_position", rect_position, rect_position - Vector2(54, 0), 1)
	$Tween.start()
