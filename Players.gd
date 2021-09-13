extends Node

export var player_template_scene: PackedScene
var player_names: Array
var player_images: Array

var _image_type = ".jpg"

func _ready():
	var filenames: Array = _get_filenames("players")
	print("got filenames")
	var filtered: Array = _filter_extension(filenames, _image_type)
	print("filtered ", filtered)
	
	for file_name in filtered:
		var player_name: String = _trim_extension(file_name, _image_type)
		player_names.append(player_name)
		
		var player_image: Image = _create_image(file_name)
		player_images.append(player_image)
	
		
func _create_image(file_name: String) -> Image:
	var image: Image = Image.new()
	image.load("players/"+file_name)
	return image

func _filter_extension(filenames: Array, extension: String) -> Array:
	var filtered: Array
	for x in filenames:
		var file_name: String = x as String
		if file_name.ends_with(extension):
			filtered.append(file_name)
	return filtered
	
func _trim_extension(file_name: String, extension: String) -> String:
	return file_name.trim_suffix(extension)
	

func _get_filenames(folder_path: String) -> Array:
	var filenames: Array
	var directory = Directory.new()
	if directory.open(folder_path) == OK:
		directory.list_dir_begin(true)
		var file_name = directory.get_next()
		while file_name != "":
				filenames.append(file_name)
				file_name = directory.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return filenames
	
func get_player_image(player_name):
	var index = player_names.find(player_name)
	if index == -1:
		return null
	
	return player_images[index]
