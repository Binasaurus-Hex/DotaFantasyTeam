tool
extends Control

class_name PlayerTemplate

signal pressed(player_name)

var player_name: String setget _set_player_name
var player_image: Image setget _set_player_image

var image_size: float = 80.0

func disable():
	$Button.disabled = true
	modulate = Color(0.2,0.2,0.2,1)

func _set_player_name(value: String):
	$VBoxContainer/Name.text = value
	player_name = value

func _set_player_image(image: Image):
	var atlas_texture: AtlasTexture = AtlasTexture.new()
	var image_texture: ImageTexture = ImageTexture.new()
	image_texture.create_from_image(image)
	var width = image.get_width()
	var height = image.get_height()
	
	var max_dimension: float = min(width,height)
	var scaling: float = image_size / max_dimension
	
	image_texture.set_size_override(Vector2(width * scaling, height * scaling))
	atlas_texture.atlas = image_texture
	atlas_texture.region = Rect2(Vector2(0,0), Vector2(image_size,image_size))
	$VBoxContainer/Headshot.texture = atlas_texture
	player_image = image

func _on_pressed():
	emit_signal("pressed",player_name)
