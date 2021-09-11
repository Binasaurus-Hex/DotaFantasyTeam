tool
extends PanelContainer

class_name PlayerTemplate

func set_player_name(value: String):
	$VBoxContainer/Name.text = value

func set_player_image(image: Image):
	var image_texture: ImageTexture = ImageTexture.new()
	image_texture.create_from_image(image)
	image_texture.set_size_override(Vector2(100,100))
	$VBoxContainer/Headshot.texture = image_texture
