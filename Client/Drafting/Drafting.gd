extends Control

var my_participant_name: String
var participants: Array
var players: Array

export var participants_ui_path: NodePath
onready var participants_ui = get_node(participants_ui_path)

export var participant_template_scene: PackedScene

func _ready():
	init_participants()
	ConnectionBridge.connect("drafting_participant", self, "_on_draft_participant")
	
func init_participants():
	for participant in participants:
		var participant_template = participant_template_scene.instance()
		participant_template.participant_name = participant.name
		participants_ui.add_child(participant_template)
		
func _on_draft_participant(participant_name):
	pass
	
	
