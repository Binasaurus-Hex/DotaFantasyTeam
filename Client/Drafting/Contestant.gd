extends PanelContainer

export var player_template_scene: PackedScene

export var players_container_path: NodePath
onready var players_container = get_node(players_container_path)

export var participant_name: String setget set_participant_name
var players: Array
var current_index = 0

func _ready():
	for i in range(5):
		players_container.add_child(player_template_scene.instance())

func set_participant_name(value: String):
	$HBoxContainer/Name.text = value
	participant_name = value
	
func add_player(player_name):
	players.append(player_name)
	var player_template: PlayerTemplate = players_container.get_child(current_index)
	player_template.player_name = player_name
	player_template.player_image = Players.get_player_image(player_name)
	current_index += 1
	
