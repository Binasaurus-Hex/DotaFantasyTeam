extends Control

export var next_scene: PackedScene

func _ready():
	$Label.modulate.a = 0
	$Tween.interpolate_property($Label,"modulate:a", 0, 1, 2)
	$Tween.start()
	$Timer.start(5)
	yield($Timer,"timeout")
	$Tween.interpolate_property($Label,"modulate:a", 1, 0, 3)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	get_tree().change_scene_to(next_scene)
