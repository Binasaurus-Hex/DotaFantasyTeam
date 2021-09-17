extends Node

signal drafting_participant(participant)
signal participant_joined(participant)
signal all_participants(participants)

signal player_chosen()
signal player_selected()

signal draft_time(time)
signal wait_time(time)

signal drafting_complete()

signal start_game()
signal completed_game(participant)

func send(signal_name, value):
	rpc("recieve", signal_name, value)
	
remote func recieve(signal_name, value):
	emit_signal(signal_name, value)
