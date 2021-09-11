extends Control

var participants: Array
var players: Array

export var player_template_scene: PackedScene

func _ready():
	$HTTPRequest.request("https://api.opendota.com/api/proPlayers")
	var result = yield($HTTPRequest,"request_completed")
	var body = result[3]
	var json = JSON.parse(body.get_string_from_utf8()).result
	for player in json:
		yield(add_player(player),"completed")
	
func add_player(player):
	var player_image: Image = yield(get_image(player.avatarmedium), "completed")
	var player_template = create_player_template(player.name, player_image)
	$VBoxContainer/Drafting/ScrollContainer/PlayersGrid.add_child(player_template)
	
func get_image(url: String):
	$HTTPRequest.request(url)
	var result = yield($HTTPRequest,"request_completed")
	var image: Image = Image.new()
	image.load_jpg_from_buffer(result[3])
	return image
	
func create_player_template(player_name: String, player_image: Image):
	var player_template: PlayerTemplate = player_template_scene.instance()
	player_template.set_player_name(player_name)
	player_template.set_player_image(player_image)
	return player_template
	
	
	
