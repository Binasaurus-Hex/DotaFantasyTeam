tool
extends Control

class_name PlayerTemplate

func set_player_name(value: String):
	$VBoxContainer/Name.text = value

func set_player_image(image: Image):
	var atlas_texture: AtlasTexture = AtlasTexture.new()
	var image_texture: ImageTexture = ImageTexture.new()
	image_texture.create_from_image(image)
	var width = image.get_width()
	var height = image.get_height()
	
	var max_dimension: float = min(width,height)
	var scaling: float = 100.0 / max_dimension
	
	image_texture.set_size_override(Vector2(width * scaling, height * scaling))
	atlas_texture.atlas = image_texture
	atlas_texture.region = Rect2(Vector2(0,0), Vector2(100,100))
	$VBoxContainer/Headshot.texture = atlas_texture


