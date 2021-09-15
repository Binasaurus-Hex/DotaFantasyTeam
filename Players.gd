extends Node

export var player_template_scene: PackedScene
var player_names = ['23savage', '4dr', 'abed', 'ame', 'arteezy', 'borax',
					'bryle', 'ceb', 'chris', 'chyuan', 'collapse', 'costabile',
					'cr1t-', 'deth', 'dj', 'dm', 'dubu', 'dy', 'eleven', 'emo',
					'eurus', 'faith_bian', 'fly', 'flyfly', 'fng', 'frank', 'fy',
					'gpk', 'handsken', 'iceiceice', 'jabz', 'jt-', 'k1', 'kaka', 'karl',
					'kingslayer', 'kj', 'kuku', 'lanm', 'leostyle-', 'limmp',
					'matumbaman', 'miposhka', 'miroslaw', 'mjz', 'mnz', 'monet',
					'moonmeander', 'mooz', 'mss', 'n0tail', 'nightfall', 'nikobaby',
					'nisha', 'nothingtosay', 'oli', 'ori', 'poyoyo', 'puppey', 'pyw',
					'quinn', 'raven', 's4', 'saberlight-', 'saksa', 'save-', 'scofield',
					'somnusm', 'stinger', 'sumail', 'super', 'svg', 'tavo', 'thiolicor',
					'timado', 'topson', 'torontotokyo', 'whitealbum', 'whitemon', 'wisper',
					'xepher', 'xinq', 'xxs', "y'", 'yang', 'yapzor', 'yatoro', 'yawar', 'zai']

export(String, DIR) var image_folder
var player_images: Array
var _image_type = ".jpg"

func _ready():
	load_images()

func load_images():
	for player_name in player_names:
		var image: Image = _create_image(image_folder + "/" + player_name + ".jpg")
		player_images.append(image)
		
func _create_image(file_name: String) -> Image:
	var image: Image = load(file_name)
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
