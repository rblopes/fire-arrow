extends HBoxContainer

@onready
var _icon_button_scene: PackedScene = get_meta("icon_button")

@onready
var _icon_defs: Dictionary = get_meta("icon_defs")


func add_icon_buttons(icon_keys: Array[StringName], is_pinned: bool) -> void:
	for key: StringName in icon_keys:
		var icons := _get_icons(key)
		if not is_pinned:
			# Remove the "unknown" icon of this hint's icon list.
			icons.pop_front()
		add_child(_instantiate_icon_button(icons))


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


func _get_icons(key: StringName) -> Array[Resource]:
	assert(key in _icon_defs)
	var result: Array[Resource] = []
	result.assign(_icon_defs[key].duplicate())
	return result


func _instantiate_icon_button(items: Array[Resource]) -> Button:
	var result := _icon_button_scene.instantiate()
	result.items = items
	return result
