extends "../hint.gd"

export var goal: Resource setget set_goal


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_button_cycle_backward"):
			goal.cycle_backward()
		if event.is_action_pressed("ui_mouse_button_cycle_forward"):
			goal.cycle_forward()


func _on_goal_changed() -> void:
	$contents/goal.text = goal.get_choice()


func _ready() -> void:
	if is_instance_valid(goal):
		$contents/goal.text = goal.get_choice()


func can_drop_data(at_position: Vector2, data) -> bool:
	return data is Item or data is Song or data is Prize


func drop_data(at_position: Vector2, data) -> void:
	$contents/item_tray.add_item_icon(data)


func queue_free_on_reset() -> void:
	queue_free()


func set_goal(value: Goal) -> void:
	if is_instance_valid(value):
		goal = value
		goal.connect("changed", self, "_on_goal_changed")
