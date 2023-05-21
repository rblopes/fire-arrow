extends Node

const SCREENSHOT_FILENAME_FORMAT_MASK := "%04d-%02d-%02d %02d-%02d-%02d.png"

@export
var screenshot_output_path: String = ""

@onready
var _icon_drag_preview_scene: PackedScene = get_meta("icon_drag_preview_scene")


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


func get_shortcut(key_combination: String) -> Shortcut:
	var result := Shortcut.new()
	var event := InputEventKey.new()
	for part in key_combination.split("+"):
		match part:
			"Alt":
				event.alt_pressed = true
			"Control":
				event.ctrl_pressed = true
			"Shift":
				event.shift_pressed = true
			"Meta":
				event.meta_pressed = true
			_:
				event.keycode = OS.find_keycode_from_string(part)
	result.events.append(event)
	return result


func set_drag_preview_for(control: Control, data: Variant) -> void:
	var preview: Control = _icon_drag_preview_scene.instantiate()
	preview.texture = data.texture if "texture" in data else null
	control.set_drag_preview(preview)


func take_screenshot(viewport: Viewport) -> void:
	if not DirAccess.dir_exists_absolute(screenshot_output_path):
		if DirAccess.make_dir_recursive_absolute(screenshot_output_path) != OK:
			return
	var image := viewport.get_texture().get_image()
	image.save_png(screenshot_output_path.path_join(_get_screenshot_filename()))
