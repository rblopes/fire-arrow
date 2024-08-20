extends "../../hint.gd"


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return hint.has_icon and data is Item or data is Song


func _drop_data(at_position: Vector2, data: Variant) -> void:
	%Icon.set_icon(data)


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_right_button"):
		$State.reset()


func _on_state_updated(symbol: String) -> void:
	%Symbol.text = symbol


func _ready() -> void:
	super()
	shortcut = hint.shortcut if is_instance_valid(hint) else null
	%Icon.visible = hint.has_icon
	$State.updated.connect(_on_state_updated)
	reset()


func get_filter() -> HintGroupFilter:
	return $State.get_filter()


func reset() -> void:
	%Icon.set_icon()
	$State.reset()


func set_hint(value: Hint) -> void:
	if is_instance_valid(value):
		hint = value
		shortcut = hint.shortcut
		$State.hint = hint
