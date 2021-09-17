extends Control

export var next_scene: PackedScene
export var text_path: NodePath

func _ready():
	var peer := NetworkedMultiplayerENet.new()
	peer.create_client("www.sanderbot.uk", 8080)
	get_tree().network_peer = peer
	
	if Commandline.arguments.has("name"):
		SessionData.participant_name = Commandline.arguments.name

func _on_Button_pressed():
	var text = get_node(text_path).text
	SessionData.participant_name = text
	name_selected(SessionData.participant_name)
	
func name_selected(participant_name):
	ConnectionBridge.send("participant_joined",participant_name)
	get_tree().change_scene_to(next_scene)

func _on_Timer_timeout():
	if SessionData.participant_name:
		name_selected(SessionData.participant_name)
