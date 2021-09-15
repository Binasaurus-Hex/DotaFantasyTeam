extends Control

export var waiting_scene: PackedScene
var participant_arg

func _ready():
	var peer := NetworkedMultiplayerENet.new()
	peer.create_client("www.sanderbot.uk", 8080)
	get_tree().network_peer = peer
	
	var arguments = {}
	for argument in OS.get_cmdline_args():
		if argument.find("=") > -1:
			var key_value = argument.split("=")
			arguments[key_value[0].lstrip("--")] = key_value[1]
	
	var participant_name = arguments.get("name")
	if participant_name != null:
		participant_arg = participant_name

func _on_Button_pressed():
	var text = $HBoxContainer/TextEdit.text
	name_selected(text)
	
func name_selected(participant_name):
	ConnectionBridge.send("participant_joined",participant_name)
	var waiting = waiting_scene.instance()
	waiting.my_participant_name = participant_name
	var root = get_tree().root
	root.remove_child(self)
	root.add_child(waiting)

func _on_Timer_timeout():
	if participant_arg:
		name_selected(participant_arg)
