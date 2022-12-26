extends TextureRect

export var item: Resource setget set_item


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_mouse_button_cycle_backward"):
		item.cycle_backward()
	if event.is_action_released("ui_mouse_button_cycle_forward"):
		item.cycle_forward()


func can_drop_data(_position: Vector2, data) -> bool:
	return data is Item or data is Song or data is Prize


func drop_data(_position: Vector2, data) -> void:
	texture = data.get_icon_texture()


func refresh() -> void:
	texture = item.get_icon_texture()


func set_item(value: Item) -> void:
	item = value
	item.connect("changed", self, "refresh")
	refresh()
