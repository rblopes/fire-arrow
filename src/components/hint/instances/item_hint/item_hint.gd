extends "../../hint.gd"


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return is_instance_valid(data) and len(hint.icons) == 1 and (data is Item or data is Song)


func _drop_data(at_position: Vector2, data: Variant) -> void:
	%Icons.set_icon(data)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_right_button") and not hint.is_pinned():
			queue_free()
		elif event.is_action_pressed("ui_mouse_button_cycle_backward"):
			%Icons.cycle_icons_backward()
		elif event.is_action_pressed("ui_mouse_button_cycle_forward"):
			%Icons.cycle_icons_forward()


func _ready() -> void:
	super()
	if is_instance_valid(hint):
		%Symbol.text = hint.get_symbol()
		%Icons.add_icon_buttons(hint.icons, hint.is_pinned())
		%Icons.reset()


func reset() -> void:
	if hint.is_pinned():
		%Icons.reset()
	else:
		queue_free()
