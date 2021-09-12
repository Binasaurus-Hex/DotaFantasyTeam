extends Node

signal drafting_participant(participant)
signal participant_joined(participant)
signal all_participants(participants)
signal player_selected(player_name, participant)


# DRAFTING
func send_drafting_participant(participant):
	rpc("recieve_drafting_participant", participant)
	
remote func recieve_drafting_participant(participant):
	emit_signal("drafting_participant", participant)
	
# PARTICIPANT JOINED
func send_participant_joined(participant: String):
	rpc("recieve_participant_joined", participant)

remote func recieve_participant_joined(participant):
	emit_signal("participant_joined", participant)
	
	
# ALL CONNECTED
func send_all_participants(participants: Array):
	rpc("recieve_all_participants", participants)

remote func recieve_all_participants(participants):
	emit_signal("all_participants", participants)
