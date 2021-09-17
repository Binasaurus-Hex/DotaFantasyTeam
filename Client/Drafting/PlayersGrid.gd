extends GridContainer

export var player_template_scene: PackedScene

export var participants_path: NodePath
onready var participants = get_node(participants_path)

var enabled: bool = false

var available_players: Array = (Players.player_names).duplicate()

func _ready():
	
	ConnectionBridge.connect("player_chosen", self, "_on_player_chosen")
	
	for i in range(len(Players.player_names)):
		var player_template: PlayerTemplate = player_template_scene.instance()
		player_template.player_name = Players.player_names[i]
		player_template.player_image = Players.player_images[i]
		player_template.connect("pressed", self, "_on_player_pressed")
		add_child(player_template)

func _on_player_pressed(player_name: String):
	if not enabled:
		return
	ConnectionBridge.send("player_selected", [SessionData.participant_name, player_name])
	enabled = false
	
func _on_player_chosen(args: Array):
	var player_name = args[1]
	choose_player(player_name)

func choose_player(player_name):
	available_players.erase(player_name)
	for child in get_children():
		if child.player_name == player_name:
			child.disable()
