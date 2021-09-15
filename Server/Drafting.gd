extends Node

var participants: Array setget _set_participants
var available_players: Array = (Players.player_names).duplicate()

var current_drafter: Dictionary

var draft_order: Array

var player_selected: bool = false

signal completed()

func _ready():
	ConnectionBridge.connect("player_selected", self, "_on_player_selected")
	
func _set_participants(value):
	participants = value
	draft_order = generate_draft_order(participants.size())
	
func start():
	$WaitTimer.start()
	yield($WaitTimer,"timeout")
	draft()

func draft():
	$DraftingTimer.start()
	for index in draft_order:
		current_drafter = participants[index]
		player_selected = false
		ConnectionBridge.send("drafting_participant", current_drafter.name)
		yield($DraftingTimer,"timeout")
		if not player_selected:
			choose_player(random_player())
			
	$DraftingTimer.stop()
	emit_signal("completed")

func _on_player_selected(player):
	choose_player(player)
	player_selected = true

func generate_draft_order(number_of_participants) -> Array:
	var draft_order: Array
	var slots = 5
	for i in range(slots):
		var sequence = range(number_of_participants)
		if i % 2 == 0: # is even
			sequence.invert()
		draft_order.append_array(sequence)
		
	return draft_order
	
func choose_player(player):
	current_drafter.players.append(player)
	available_players.erase(player)
	ConnectionBridge.send("player_selected", [current_drafter.name, player])
	
func random_player():
	var length = available_players.size()
	var index = randi() % length
	return available_players[index]
