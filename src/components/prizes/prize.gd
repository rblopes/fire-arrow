extends Control

export var prize: Resource setget set_prize


func _gui_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if event.is_action_released("ui_mouse_left_button"):
		prize.is_checked = not prize.is_checked
	if event.is_action_released("ui_mouse_right_button"):
		owner.request_context_menu(event.global_position)


func can_drop_data(at_position: Vector2, data: Prize) -> bool:
	return data is Prize


func drop_data(at_position: Vector2, data: Prize) -> void:
	owner.assign_symbol(data, prize)


func get_drag_data(at_position: Vector2) -> Prize:
	return UiHelper.set_icon_drag_preview_for(self, prize)


func refresh() -> void:
	$icon.material.set_shader_param("disabled", prize.is_checked)
	$symbol.text = prize.assigned_label


func set_prize(value: Prize) -> void:
	prize = value
	prize.connect("changed", self, "refresh")
	$icon.texture = prize.get_icon_texture()
	refresh()
