extends Node

@onready
var _icon_drag_preview_scene: PackedScene = get_meta("icon_drag_preview_scene")


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
	preview.texture = data.get("texture")
	control.set_drag_preview(preview)


func take_screenshot(dir: String, viewport: Viewport) -> void:
	if not DirAccess.dir_exists_absolute(dir):
		return
	var image := viewport.get_texture().get_image()
	image.save_png(dir.path_join(_get_screenshot_filename()))


func _get_screenshot_filename() -> String:
	return str(Time.get_datetime_string_from_system(false, true).replace(":", '-'), ".png")
