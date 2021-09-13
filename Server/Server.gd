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
	
	ConnectionBridge.connect("participant_joined", self, "_participant_connected")
	
func _participant_connected(participant_name):
	participants.append({
		"name":participant_name,
		"players":[]
	})
	
	if len(participants) == max_clients:
		participants_connected()
		
func participants_connected():
	ConnectionBridge.send("all_participants", participants)
	$WaitTimer.start()
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

func iterate_draft():
	var current_index = draft_order.pop_back()
	if current_index == null:
		on_draft_finished()
		return
	var participant = participants[current_index]
	ConnectionBridge.send("drafting_participant",participant.name)
	
func on_draft_finished():
	$DraftingTimer.stop()
	
func on_drafting_seconds(seconds):
	ConnectionBridge.send("draft_time", seconds)

func on_wait_seconds(seconds):
	ConnectionBridge.send("wait_time", seconds)
	
func on_drafting_timeout():
	iterate_draft()

func on_wait_timeout():
	iterate_draft()
	$DraftingTimer.start()
