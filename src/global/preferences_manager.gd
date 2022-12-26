extends Node

const CONFIG_KEY := "application/config/preferences_path"

var preferences_file := ConfigFile.new()
var preferences_path: String = ProjectSettings.get_setting(CONFIG_KEY)


func _init() -> void:
	load_preferences()


func get_value(section, key, default = null):
	return preferences_file.get_value(section, key, default)


func load_preferences() -> void:
	if preferences_file.load(preferences_path) != OK:
		reset_preferences()


func reset_preferences() -> void:
	var preferences := Const.DEFAULT_PREFERENCES
	for section in preferences:
		for key in preferences[section]:
			preferences_file.set_value(section, key, preferences[section][key])


func save_preferences() -> void:
	preferences_file.save(preferences_path)


func set_value(section, key, value) -> void:
	preferences_file.set_value(section, key, value)
