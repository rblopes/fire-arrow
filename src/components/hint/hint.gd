extends Button

signal removal_requested(hint)

var hint: Hint = null:
	set = set_hint


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not hint.is_pinned() and event.is_action_released("ui_mouse_right_button"):
			removal_requested.emit(hint)
			queue_free()


func _ready() -> void:
	if is_instance_valid(hint):
		%Description.text = hint.description


func reset() -> void:
	if not hint.is_pinned():
		removal_requested.emit(hint)
		queue_free()


func set_hint(value: Hint) -> void:
	if is_instance_valid(value):
		hint = value
