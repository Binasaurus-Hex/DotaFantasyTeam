extends VBoxContainer

var currently_drafting

func highlight_participant(participant_name):
	currently_drafting = participant_name
	for child in get_children():
		var selection_indicator = child.get_node("SelectionIndicator")
		if child.participant_name == participant_name:
			print("matched")
			selection_indicator.select()
		else:
			selection_indicator.deselect()
			
func get_participant_ui(participant):
	for child in get_children():
		if child.participant_name == participant:
			return child
	return null
