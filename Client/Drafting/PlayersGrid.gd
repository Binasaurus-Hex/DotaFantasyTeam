extends GridContainer

export var player_template_scene: PackedScene

export var participants_path: NodePath
onready var participants = get_node(participants_path)

func _ready():
	for i in range(len(Players.player_names)):
		var player_template: PlayerTemplate = player_template_scene.instance()
		player_template.player_name = Players.player_names[i]
		player_template.player_image = Players.player_images[i]
		player_template.connect("selected", self, "on_player_selected")
		add_child(player_template)

func on_player_selected(player_name: String):
	var drafter = participants.get_participant_ui(participants.currently_drafting)
	drafter.add_player(player_name)
