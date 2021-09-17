extends Node2D

const port = 8080
var max_clients: int = 8

var participants: Array

var play_game: bool = false

func _ready():
	if Commandline.arguments.has("play_game"):
		play_game = Commandline.arguments.play_game as bool
	if Commandline.arguments.has("max_users"):
		max_clients = Commandline.arguments.max_users as int
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
	
	elif participants.size() == max_clients:
		return
		
	else:
		participants.append({
			"name":participant_name,
			"players":[]
		})
		print(participant_name, " connected")
		
		if participants.size() == max_clients:
			participants_connected()
			
func find_participant(participant_name):
	for participant in participants:
		if participant.name == participant_name:
			return participant
	return null
	
func participants_connected():
	
	if play_game:
		ConnectionBridge.send("start_game", [])
		$DraftOrder.max_participants = max_clients
		yield($DraftOrder, "all_completed")
		participants = $DraftOrder.get_reordered_participants(participants)
	
	ConnectionBridge.send("all_participants", participants)
	
	$Drafting.participants = participants
	$Drafting.start()
	
	yield($Drafting,"completed")
	ConnectionBridge.send("drafting_complete",[])
	
	store("participants.txt", participants)
	
func store(file_name, data):
	var file = File.new()
	file.open(file_name, File.WRITE)
	file.store_string(data as String)
	file.close()



