extends Node

var participants_ordered: Array
var max_participants: int
var count = 0

signal all_completed()

func _ready():
	ConnectionBridge.connect("completed_game", self, "_on_participant_completed")
	
func _on_participant_completed(participant_name):
	participants_ordered.append(participant_name)
	count += 1
	if count == max_participants:
		emit_signal("all_completed")

func get_reordered_participants(participants: Array) -> Array:
	var reordered: Array
	for participant in participants:
		var index = participants_ordered.find(participant.name)
		reordered.insert(index, participant)
	return reordered
