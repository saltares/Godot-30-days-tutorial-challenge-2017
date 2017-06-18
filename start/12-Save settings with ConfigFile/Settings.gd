# Stores, saves and loads game Settings in an ini-style file
extends Node


const SAVE_PATH = "res://config.cfg"

var _config_file = ConfigFile.new()
var _settings = {
    "audio": {
        "mute": Globals.get("Settings/mute")
    },
    "debug": {
        "vector_color": Color(1.0, 0.0, 1.0),
        "area_color": Color(0.0, 0.0, 0.2, 0.5)
    }
}


func _ready():
#    save_settings()
    load_settings()


func save_settings():
	for section in _settings.keys():
		for key in _settings[section].keys():
			_config_file.set_value(section, key, _settings[section][key])

	_config_file.save(SAVE_PATH)

func load_settings():
	var rc = _config_file.load(SAVE_PATH)
	if rc != OK:
		print("Failed loading file. Error code %s" % rc)
		return []

	for section in _settings.keys():
		for key in _settings[section].keys():
			_settings[section][key] = _config_file.get_value(section, key, null)

func get_setting(category, key):
    return _settings[category][key]


func set_setting(category, key, value):
    _settings[category][key] = value