extends PanelContainer

export var participant_name: String setget set_participant_name

func set_participant_name(value: String):
	$HBoxContainer/HBoxContainer2/Name.text = value
	participant_name = value
