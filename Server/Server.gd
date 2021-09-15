extends Node2D

const port = 8080
const max_clients = 2

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
	if find_participant(participant_name): # someone is reconnecting
		ConnectionBridge.send("all_participants", participants)
	else:
		participants.append({
			"name":participant_name,
			"players":[]
		})
		print(participant_name, " connected")
		
		if len(participants) == max_clients:
			participants_connected()
			
func find_participant(participant_name):
	for participant in participants:
		if participant.name == participant_name:
			return participant
	return null
	
func participants_connected():
	ConnectionBridge.send("all_participants", participants)
	$Drafting.participants = participants
	$Drafting.start()
	
	yield($Drafting,"completed")
	ConnectionBridge.send("drafting_complete",[])
	
	var draft_file = File.new()
	draft_file.open("draft_file.txt", File.WRITE)
	draft_file.store_string(participants as String)
	draft_file.close()



