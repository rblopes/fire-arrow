extends Control

@export
var item: Item:
	set(value):
		item = value
		item.changed.connect(_on_item_changed)
		$Icon.texture = item.get_icon_texture()


func _get_drag_data(at_position: Vector2):
	return UiHelper.set_icon_drag_preview_for(self, item)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_released("ui_mouse_button_cycle_backward"):
			item.cycle_backward()
		if event.is_action_released("ui_mouse_button_cycle_forward"):
			item.cycle_forward()


func _on_item_changed() -> void:
	$Icon.texture = item.get_icon_texture()
	$Icon.material.set_shader_parameter("disabled", item.is_checked)
	$Label.text = item.get_label()
	$Label.visible = item.uses_label and item.is_checked
