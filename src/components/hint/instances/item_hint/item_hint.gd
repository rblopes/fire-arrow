extends "../../hint.gd"

@export
var items: Array[Item] = []:
	set(value):
		items = value.duplicate()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_right_button") and not hint.is_pinned():
			removal_requested.emit(hint)
			queue_free()
		elif event.is_action_pressed("ui_mouse_button_cycle_backward"):
			$State.decrease()
		elif event.is_action_pressed("ui_mouse_button_cycle_forward"):
			$State.increase()


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Item or data is Song or data is Prize


func _drop_data(at_position: Vector2, data: Variant) -> void:
	if is_instance_valid(data):
		%Item.texture = data.texture


func _on_state_updated(current_item: Item) -> void:
	if is_instance_valid(current_item):
		%Item.texture = current_item.texture


func _ready() -> void:
	super()
	if is_instance_valid(hint):
		%Symbol.text = hint.get_symbol()
		if not hint.pinned:
			items.pop_front() # Remove "unknown" icon.
	$State.items = items
	$State.reset()


func reset() -> void:
	if hint.is_pinned():
		$State.reset()
	else:
		removal_requested.emit(hint)
		queue_free()
