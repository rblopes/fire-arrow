extends Button

signal removal_requested(hint)

var hint: Hint setget set_hint


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not hint.is_pinned() and event.is_action_released("ui_mouse_right_button"):
			emit_signal("removal_requested", hint)
			queue_free()


func _ready() -> void:
	if is_instance_valid(hint):
		$contents/description.text = hint.description


func queue_free_on_reset() -> void:
	pass


func set_hint(value) -> void:
	if is_instance_valid(value):
		hint = value
