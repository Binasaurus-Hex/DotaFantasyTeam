extends Node2D

export var next_scene: PackedScene

func _ready():
	ConnectionBridge.connect("all_participants", self,"_on_all_participants")

func _on_PollTimer_timeout():
	completed()

func _on_Player_winner():
	completed()
	
func completed():
	ConnectionBridge.send("completed_game", SessionData.participant_name)
	
func _on_all_participants(participants):
	SessionData.participants = participants
	get_tree().change_scene_to(next_scene)
