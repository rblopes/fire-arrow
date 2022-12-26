extends "../hint.gd"


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_right_button"):
			hint.location = null


func _on_hint_changed() -> void:
	$contents/symbol.text = hint.get_symbol()


func _ready() -> void:
	if is_instance_valid(hint):
		$contents/symbol.text = hint.get_symbol()


func _pressed() -> void:
	owner.request_hint_group_filter_dialog(hint.get_filter(), self)


func queue_free_on_reset() -> void:
	pass


func set_hint(value: SpecialLocationHint) -> void:
	if is_instance_valid(value):
		hint = value
		hint.connect("changed", self, "_on_hint_changed")
		shortcut = hint.shortcut
