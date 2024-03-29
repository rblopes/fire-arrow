extends Button

var hint: Hint = null:
	set = set_hint


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_mouse_right_button"):
		if not (hint is MiscellaneousHint and hint.is_pinned()):
			queue_free()


func _ready() -> void:
	if is_instance_valid(hint):
		%Description.text = hint.description


func reset() -> void:
	if not (hint is MiscellaneousHint and hint.is_pinned()):
		queue_free()


func set_hint(value: Hint) -> void:
	if is_instance_valid(value):
		hint = value
