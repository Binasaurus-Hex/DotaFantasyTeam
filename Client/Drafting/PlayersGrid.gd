extends GridContainer

export var player_template_scene: PackedScene

export var participants_path: NodePath
onready var participants = get_node(participants_path)

var available_players: Array = (Players.player_names).duplicate()

func _ready():
	
	ConnectionBridge.connect("player_selected", self, "_on_player_selected")
	
	for i in range(len(Players.player_names)):
		var player_template: PlayerTemplate = player_template_scene.instance()
		player_template.player_name = Players.player_names[i]
		player_template.player_image = Players.player_images[i]
		player_template.connect("pressed", self, "on_player_selected")
		add_child(player_template)

func _on_player_pressed(player_name: String):
	var drafter = participants.get_participant_ui(participants.currently_drafting)
	drafter.add_player(player_name)
	
func _on_player_selected(args: Array):
	var player_name = args[1]
	available_players.erase(player_name)
	for child in get_children():
		if child.player_name == player_name:
			child.disable()
