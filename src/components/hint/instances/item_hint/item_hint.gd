extends "../../hint.gd"

@export
var items: Array[Item] = []:
	set(value):
		assert(len(value) > 0)
		items = value.duplicate()


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return hint.icons == 1 and is_instance_valid(data) and (data is Item or data is Prize or data is Song)


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
		if not hint.pinned:
			items.pop_front() # Remove "unknown" icon.
		%Icons.add_icon_buttons(hint.icons, items)
		%Icons.reset()


func reset() -> void:
	if hint.is_pinned():
		%Icons.reset()
	else:
		queue_free()
