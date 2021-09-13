extends Control

export var waiting_scene: PackedScene

func _ready():
	var peer := NetworkedMultiplayerENet.new()
	peer.create_client("127.0.0.1", 8080)
	get_tree().network_peer = peer

func _on_Button_pressed():
	var text = $HBoxContainer/TextEdit.text
	ConnectionBridge.send("participant_joined",text)
	var waiting = waiting_scene.instance()
	waiting.my_participant = text
	var root = get_tree().root
	root.remove_child(self)
	root.add_child(waiting)
