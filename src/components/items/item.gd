extends Control

export var item: Resource setget set_item


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_released("ui_mouse_button_cycle_backward"):
			item.cycle_backward()
		if event.is_action_released("ui_mouse_button_cycle_forward"):
			item.cycle_forward()
		accept_event()


func get_drag_data(position: Vector2):
	return UiHelper.set_icon_drag_preview_for(self, item)


func refresh() -> void:
	$icon.texture = item.get_icon_texture()
	$icon.material.set_shader_param("disabled", item.is_checked)
	$label.text = item.get_label()
	$label.visible = item.uses_label and item.is_checked


func set_item(value: Item) -> void:
	item = value
	item.connect("changed", self, "refresh")
	refresh()
