extends Node

signal updated()

const CONFIG_KEY: String = "application/config/preferences_path"
const SCREENSHOTS_OUTDIR: String = "user://Screenshots"
const DEFAULT_SETTINGS: Dictionary = {
	"songs": {
		"drag_and_drop": true,
		"autocheck": true,
		"check_in_reverse": false,
	},
	"prizes": {
		"drag_and_drop": true,
		"check_in_reverse": false,
	},
	"stopwatch": {
		"enabled": true,
	},
	"screenshots": {
		"outdir": SCREENSHOTS_OUTDIR,
	},
	"tracker": {
		"preset": "standard_s6"
	},
	"window": {
		"height": 360,
		"width": 672,
	},
}

var _config_file := ConfigFile.new()
var _config_path: String = ProjectSettings.get_setting(CONFIG_KEY)


func _init() -> void:
	_fill_in_default_settings()
	if _config_file.load(_config_path) != OK:
		save()


func get_value(section: String, key: String, default_value: Variant = null) -> Variant:
	return _config_file.get_value(section, key, default_value)


func is_default_screenshot_outdir(dir: String) -> bool:
	return dir == SCREENSHOTS_OUTDIR


func set_value(section: String, key: String, value: Variant) -> void:
	_config_file.set_value(section, key, value)
	updated.emit()


func save() -> void:
	_config_file.save(_config_path)


func show_dialog() -> void:
	$Dialog.reset_fields({
		"songs_drag_and_drop": get_value("songs", "drag_and_drop"),
		"songs_autocheck": get_value("songs", "autocheck"),
		"songs_check_in_reverse": get_value("songs", "check_in_reverse"),
		"prizes_drag_and_drop": get_value("prizes", "drag_and_drop"),
		"prizes_check_in_reverse": get_value("prizes", "check_in_reverse"),
		"stopwatch_enabled": get_value("stopwatch", "enabled"),
		"screenshots_outdir": get_value("screenshots", "outdir"),
	})
	$Dialog.popup_centered()


func _fill_in_default_settings() -> void:
	for section in DEFAULT_SETTINGS:
		for key in DEFAULT_SETTINGS[section]:
			_config_file.set_value(section, key, DEFAULT_SETTINGS[section][key])


func _on_dialog_setting_changed(section: String, key: String, value: Variant) -> void:
	set_value(section, key, value)
	save()
