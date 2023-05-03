extends Control

signal context_menu_requested(at_position: Vector2)

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
			$Icon.texture = prize.texture

var should_check_in_reverse: bool


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Prize


func _drop_data(at_position: Vector2, dropped_prize: Variant) -> void:
	if should_check_in_reverse:
		prize.assigned_label = dropped_prize.label
		prize.is_checked = prize.is_checked or dropped_prize.is_free
	else:
		dropped_prize.assigned_label = prize.label
		dropped_prize.is_checked = dropped_prize.is_checked or prize.is_free


func _get_drag_data(at_position: Vector2) -> Variant:
	UiHelper.set_drag_preview_for(self, prize)
	return prize


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_mouse_left_button"):
		prize.is_checked = not prize.is_checked
	if event.is_action_released("ui_mouse_right_button"):
		context_menu_requested.emit(event.global_position)
	if event.is_action_pressed("ui_mouse_button_wheel_up"):
		goal.cycle_backward()
	if event.is_action_pressed("ui_mouse_button_wheel_down"):
		goal.cycle_forward()


func _on_goal_changed() -> void:
	prize.assigned_label = goal.get_choice()


func _on_prize_changed() -> void:
	$Icon.material.set_shader_parameter("disabled", prize.is_checked)
	$Label.text = prize.assigned_label
	if prize.assigned_label == Prize.UNDEFINED_LABEL:
		goal.reset()


func _ready() -> void:
	reset()


func clear_label_if(type: Prize.Type) -> void:
	if prize.type == type:
		prize.assigned_label = Prize.UNDEFINED_LABEL


func reset() -> void:
	uncheck()
	prize.assigned_label = Prize.UNDEFINED_LABEL


func uncheck() -> void:
	prize.is_checked = false
