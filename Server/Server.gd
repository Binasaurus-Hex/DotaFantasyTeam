extends Node2D

const port = 8080
const max_clients = 2
onready var draft_order: Array = generate_draft_order()

var participants: Array

func _ready():
	start()
	
func start():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(port,max_clients)
	get_tree().network_peer = network
	print("server started")
	
	InternetBridge.connect("participant_joined", self, "_participant_connected")
	
func _participant_connected(participant_name):
	participants.append({
		"name":participant_name,
		"players":[]
	})
	
	if len(participants) == max_clients:
		participants_connected()
		
func participants_connected():
	InternetBridge.send_all_participants(participants)
	$StartTimer.start()
	print("all participants connected")
	
func generate_draft_order() -> Array:
	var draft_order: Array
	var slots = 5
	for i in range(slots):
		var sequence = range(max_clients)
		if is_even(i):
			sequence.invert()
		draft_order.append_array(sequence)
		
	return draft_order

func is_even(x):
	return x % 2 == 0

func _on_DraftingTimer_timeout():
	iterate_draft()

func iterate_draft():
	var current_index = draft_order.pop_back()
	if current_index == null:
		$DraftingTimer.stop()
	var participant = participants[current_index]
	InternetBridge.send_drafting_participant(participant.name)

func _on_StartTimer_timeout():
	iterate_draft()
	$DraftingTimer.start()
