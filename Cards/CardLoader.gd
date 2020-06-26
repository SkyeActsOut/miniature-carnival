extends Node

func _ready():

	var CardDatabase = get_node ("/root/GameScene/CardDatabase")
	
	# Loads all cards to the DATA variable
	for card in list_files_in_directory("res://Cards/CardData"):
		var file = File.new()
		file.open(str("res://Cards/CardData/", card), file.READ)
		var card_json = JSON.parse( file.get_as_text() ).get_result()
		CardDatabase.DATA[card_json.name] = card_json
	
	print (CardDatabase.DATA)

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files
