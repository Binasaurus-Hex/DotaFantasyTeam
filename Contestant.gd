extends PanelContainer

export var contestant_name: String setget set_contestant_name

func set_contestant_name(value: String):
	$HBoxContainer/HBoxContainer2/Name.text = value
