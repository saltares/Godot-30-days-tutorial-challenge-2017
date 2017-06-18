# Stores, saves and loads game Settings in an ini-style file
extends Node

const SAVE_PATH = "res://save.json"
var _settings = {}


func _ready():
	load_game()


func save_game():
	# Get all the save data from persistent nodes
	var save_data = {}
	var nodes_to_save = get_tree().get_nodes_in_group('persistent')
	for node in nodes_to_save:
		save_data[node.get_path()] = node.save()

	# Create a file
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)

	# Serialize the data dictionary to JSON
	save_file.store_line(save_data.to_json())

	# Write the JSON to the file and save to disk
	save_file.close()

func load_game():
	# Try to load a saved file
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return

	# Parse the file data if it exists
	save_file.open(SAVE_PATH, File.READ)
	var data = {}
	data.parse_json(save_file.get_as_text())

	# load the data into persistent nodes
	for node_path in data.keys():
		var node = get_node(node_path)

		for attribute in data[node_path]:
			if attribute == 'pos':
				node.set_pos(Vector2(
					data[node_path][attribute]['x'],
					data[node_path][attribute]['y']
				))
			else:
				node[attribute] = data[node_path][attribute]