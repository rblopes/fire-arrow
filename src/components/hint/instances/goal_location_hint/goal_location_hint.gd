extends "../../hint.gd"

@export
var goal: Goal:
	set(value):
		if is_instance_valid(value):
			goal = value
			goal.changed.connect(_on_goal_changed)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_right_button"):
			removal_requested.emit(hint)
			queue_free()
		elif event.is_action_pressed("ui_mouse_button_cycle_backward"):
			goal.cycle_backward()
		elif event.is_action_pressed("ui_mouse_button_cycle_forward"):
			goal.cycle_forward()


func _on_goal_changed() -> void:
	%Goal.text = goal.get_choice()


func _ready() -> void:
	super()
	if is_instance_valid(goal):
		%Goal.text = goal.get_choice()


func _can_drop_data(at_position: Vector2, data) -> bool:
	return data is Item or data is Song or data is Prize


func _drop_data(at_position: Vector2, data) -> void:
	%ItemTray.add_item_icon(data)
