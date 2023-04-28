extends "../../hint.gd"


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_right_button"):
		hint.location = null


func _on_state_updated(symbol: String) -> void:
	%Symbol.text = symbol


func _ready() -> void:
	super()
	shortcut = hint.shortcut if is_instance_valid(hint) else null
	$State.updated.connect(_on_state_updated)
	reset()


func get_filter() -> HintGroupFilter:
	return $State.get_filter()


func reset() -> void:
	$State.reset()


func set_hint(value: Hint) -> void:
	if is_instance_valid(value):
		hint = value
		shortcut = hint.shortcut
		$State.hint = hint
