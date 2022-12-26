extends "../hint.gd"


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_button_cycle_backward"):
			hint.decrease()
		if event.is_action_pressed("ui_mouse_button_cycle_forward"):
			hint.increase()


func _on_hint_changed() -> void:
	$contents/count.text = hint.get_formatted_count()


func _ready() -> void:
	if is_instance_valid(hint):
		$contents/count.text = hint.get_formatted_count()


func queue_free_on_reset() -> void:
	pass


func set_hint(value: CounterHint) -> void:
	if is_instance_valid(value):
		hint = value
		hint.connect("changed", self, "_on_hint_changed")
