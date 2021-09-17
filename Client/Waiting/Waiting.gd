extends Control

export var game: PackedScene
export var drafting: PackedScene

func _ready():
	ConnectionBridge.connect("all_participants", self, "_on_all_participants")
	ConnectionBridge.connect("start_game", self, "_on_start_game")
	
func _on_start_game(args):
	get_tree().change_scene_to(game)
		
func _on_all_participants(participants: Array):
	SessionData.participants = participants
	get_tree().change_scene_to(drafting)
