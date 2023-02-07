extends Control

@export
var goal: Goal:
	set(value):
		if is_instance_valid(value):
			goal = value.duplicate()
			goal.changed.connect(_on_goal_changed)

@export
var prize: Prize:
	set(value):
		if is_instance_valid(value):
			prize = value
			prize.changed.connect(_on_prize_changed)
			$Icon.texture = prize.get_icon_texture()


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Prize


func _drop_data(at_position: Vector2, data: Variant) -> void:
	owner.assign_symbol(data, prize)


func _get_drag_data(at_position: Vector2) -> Variant:
	return UiHelper.set_icon_drag_preview_for(self, prize)


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_mouse_left_button"):
		prize.is_checked = not prize.is_checked
	if event.is_action_released("ui_mouse_right_button"):
		owner.request_context_menu(event.global_position)
	if event.is_action_pressed("ui_mouse_button_wheel_up"):
		goal.cycle_backward()
	if event.is_action_pressed("ui_mouse_button_wheel_down"):
		goal.cycle_forward()


func _on_goal_changed() -> void:
	prize.assigned_label = goal.get_choice()


func _on_prize_changed() -> void:
	$Icon.material.set_shader_parameter("disabled", prize.is_checked)
	$Symbol.text = prize.assigned_label
	if prize.assigned_label == Prize.UNKNOWN_ASSIGNED_LABEL:
		goal.reset()
