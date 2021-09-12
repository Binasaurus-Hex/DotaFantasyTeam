extends GridContainer

export(String, DIR) var players_folder

export var player_template_scene: PackedScene

func _ready():
	var filenames: Array = get_filenames("players")
	print("got filenames")
	var filtered: Array = filter_extension(filenames, ".jpg")
	print("filtered ", filtered)
	
	for file_name in filtered:
		var player_template: PlayerTemplate = player_template_scene.instance()
		
		var player_name: String = trim_extension(file_name, ".jpg")
		var player_image: Image = create_image(file_name)
		
		player_template.set_player_name(player_name)
		player_template.set_player_image(player_image)
		
		add_child(player_template)
		
func create_image(file_name: String) -> Image:
	var image: Image = Image.new()
	image.load(players_folder+"/"+file_name)
	return image

func filter_extension(filenames: Array, extension: String) -> Array:
	var filtered: Array
	for x in filenames:
		var file_name: String = x as String
		if file_name.ends_with(extension):
			filtered.append(file_name)
	return filtered
	
func trim_extension(file_name: String, extension: String) -> String:
	return file_name.trim_suffix(extension)
	

func get_filenames(folder_path: String) -> Array:
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
