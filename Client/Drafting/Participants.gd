extends VBoxContainer

var currently_drafting

func _ready():
	ConnectionBridge.connect("drafting_participant", self, "_highlight_participant")
	ConnectionBridge.connect("player_chosen", self, "_on_player_chosen")

func _highlight_participant(participant_name):
	currently_drafting = participant_name
	for child in get_children():
		var selection_indicator = child.get_node("SelectionIndicator")
		if child.participant_name == participant_name:
			selection_indicator.select()
		else:
			selection_indicator.deselect()
			
func _on_player_chosen(args: Array):
	var participant_name = args[0]
	var player_name = args[1]
	print(player_name," selected")
	var ui = get_participant_ui(participant_name)
	ui.add_player(player_name)
			
func get_participant_ui(participant_name):
	for child in get_children():
		if child.participant_name == participant_name:
			return child
	return null
