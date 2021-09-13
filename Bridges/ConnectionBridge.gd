extends Node

signal drafting_participant(participant)
signal participant_joined(participant)
signal all_participants(participants)
signal player_selected(player_name, participant)
signal draft_time(time)
signal wait_time(time)

func send(signal_name, value):
	rpc("recieve", signal_name, value)
	
remote func recieve(signal_name, value):
	emit_signal(signal_name, value)
