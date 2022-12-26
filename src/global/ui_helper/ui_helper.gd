extends Node

const SCREENSHOT_FILENAME_FORMAT_MASK := "%04d-%02d-%02d %02d-%02d-%02d.png"

export var icon_drag_preview: PackedScene
export(String, FILE) var screenshot_output_path: String


func _get_screenshot_filename() -> String:
	var dt := Time.get_datetime_dict_from_system()
	return SCREENSHOT_FILENAME_FORMAT_MASK % [
		dt.year,
		dt.month,
		dt.day,
		dt.hour,
		dt.minute,
		dt.second,
	]


func get_shortcut(key_combination: String) -> ShortCut:
	var result := ShortCut.new()
	result.shortcut = InputEventKey.new()
	for part in key_combination.split("+"):
		match part:
			"Alt":
				result.shortcut.alt = true
			"Control":
				result.shortcut.control = true
			"Shift":
				result.shortcut.shift = true
			"Meta":
				result.shortcut.meta = true
			_:
				result.shortcut.scancode = OS.find_scancode_from_string(part)
	return result


func set_icon_drag_preview_for(host_control: Control, data):
	var result: Control = icon_drag_preview.instance()
	host_control.set_drag_preview(result)
	result.set_icon(data)
	return data


func take_screenshot(node: Node) -> void:
	var dir := Directory.new()
	if not dir.dir_exists(screenshot_output_path):
		if dir.make_dir_recursive(screenshot_output_path) != OK:
			return
	var image := node.get_viewport().get_texture().get_data()
	image.flip_y()
	image.save_png(screenshot_output_path.plus_file(_get_screenshot_filename()))
