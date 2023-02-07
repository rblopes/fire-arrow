extends "../hint.gd"


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_button_cycle_backward"):
			hint.decrease()
		if event.is_action_pressed("ui_mouse_button_cycle_forward"):
			hint.increase()


func _on_hint_changed() -> void:
	%Count.text = hint.get_formatted_count()


func _ready() -> void:
	super()
	if is_instance_valid(hint):
		%Count.text = hint.get_formatted_count()


func queue_free_on_reset() -> void:
	pass


func set_hint(value: Hint) -> void:
	if is_instance_valid(value):
		hint = value
		hint.changed.connect(_on_hint_changed)
