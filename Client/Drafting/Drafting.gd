extends Control

export var participants_ui_path: NodePath
onready var participants_ui = get_node(participants_ui_path)

export var player_grid_path: NodePath
onready var player_grid = get_node(player_grid_path)

export var participant_template_scene: PackedScene

export var next_scene: PackedScene

func _ready():
	init_participants()
	ConnectionBridge.connect("drafting_participant", self, "_on_draft_participant")
	ConnectionBridge.connect("drafting_complete", self, "_on_draft_complete")
	
func init_participants():
	for participant in SessionData.participants:
		var participant_template = participant_template_scene.instance()
		participant_template.participant_name = participant.name
		participants_ui.add_child(participant_template)
		for player in participant.players:
			player_grid.choose_player(player)
			participant_template.add_player(player)
		
func _on_draft_participant(participant_name):
	if participant_name == SessionData.participant_name:
		player_grid.enabled = true
	else:
		player_grid.enabled = false
		
func _on_draft_complete(array):
	pass
