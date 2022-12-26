class_name Item
extends Resource

export var acts_as_checkbox: bool
export var uses_label: bool
export(Array, Resource) var icons: Array
var is_checked: bool
var selected_icon_index: int


func cycle_backward() -> void:
	if acts_as_checkbox:
		if is_checked and selected_icon_index == 0:
			is_checked = false
		else:
			selected_icon_index = wrapi(selected_icon_index - 1, 0, icons.size())
			is_checked = true
	else:
		selected_icon_index = wrapi(selected_icon_index - 1, 0, icons.size())
	emit_changed()


func cycle_forward() -> void:
	if acts_as_checkbox:
		if is_checked:
			selected_icon_index = wrapi(selected_icon_index + 1, 0, icons.size())
			is_checked = selected_icon_index != 0
		else:
			is_checked = true
	else:
		selected_icon_index = wrapi(selected_icon_index + 1, 0, icons.size())
	emit_changed()


func get_icon_texture() -> Texture:
	return get_selected_icon().texture


func get_label() -> String:
	return get_selected_icon().label if uses_label and acts_as_checkbox and is_checked else ""


func get_selected_icon() -> Icon:
	return icons[selected_icon_index]


func uncheck() -> void:
	is_checked = false
	selected_icon_index = 0
	emit_changed()
