extends "../hint.gd"


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_right_button"):
			hint.location = null


func _on_hint_changed() -> void:
	%Symbol.text = hint.get_symbol()


func _ready() -> void:
	super()
	if is_instance_valid(hint):
		%Symbol.text = hint.get_symbol()


func _pressed() -> void:
	owner.request_hint_group_filter_dialog(hint.get_filter(), self)


func queue_free_on_reset() -> void:
	pass


func set_hint(value: Hint) -> void:
	if is_instance_valid(value):
		hint = value
		shortcut = hint.shortcut
		hint.changed.connect(_on_hint_changed)
