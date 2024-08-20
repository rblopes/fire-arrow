extends HBoxContainer

@export
var _icon_defs: ResourcePreloader


func add_icon_buttons(icon_keys: Array[StringName], is_pinned: bool) -> void:
	for key: StringName in icon_keys:
		var button := _instantiate_icon_button(key)
		if not is_pinned:
			button.items.pop_front()
		add_child(button)


func cycle_icons_backward() -> void:
	if get_child_count() > 1:
		return
	for node in get_children():
		node.cycle_backward()


func cycle_icons_forward() -> void:
	if get_child_count() > 1:
		return
	for node in get_children():
		node.cycle_forward()


func reset() -> void:
	for node in get_children():
		node.set_icon()


func set_icon(data: Variant) -> void:
	if get_child_count() == 1:
		var node := get_child(0)
		node.set_icon(data)


func _instantiate_icon_button(key: StringName) -> Button:
	assert(_icon_defs.has_resource(key), str("Icon button scene not found: ", key))
	return _icon_defs.get_resource(key).instantiate()
