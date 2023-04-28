extends "../../hint.gd"


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_button_cycle_backward"):
			$State.decrease()
		if event.is_action_pressed("ui_mouse_button_cycle_forward"):
			$State.increase()


func _on_state_updated(formatted_count: String) -> void:
	%Count.text = formatted_count


func _ready() -> void:
	super()
	$State.reset()


func reset() -> void:
	$State.reset()


func set_hint(value: Hint) -> void:
	if is_instance_valid(value):
		hint = value
		$State.hint = hint
