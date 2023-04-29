extends HBoxContainer

@onready
var _icon_button_scene: PackedScene = get_meta("icon_button")


func add_icon_buttons(count: int, items: Array[Item]) -> void:
	for i in count:
		add_child(_instantiate_icon_button(items))


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


func _instantiate_icon_button(items: Array[Item]) -> Button:
	var result := _icon_button_scene.instantiate()
	result.items = items
	return result
