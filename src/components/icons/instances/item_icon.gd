extends "../icon.gd"

@export
var items: Array[Item] = []

@onready
var _state = State.new(items)


func _ready() -> void:
	_state.updated.connect(_on_state_updated)
	_state.reset()


func reset() -> void:
	_state.reset()


func _get_drag_data(at_position: Vector2) -> Variant:
	var data: Item = _state.get_item()
	UiHelper.set_drag_preview_for(self, data)
	return data


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_released("ui_mouse_button_cycle_backward"):
			_state.cycle_backward()
		if event.is_action_released("ui_mouse_button_cycle_forward"):
			_state.cycle_forward()


func _on_state_updated(item: Item, is_checked: bool) -> void:
	if is_instance_valid(item):
		$Icon.texture = item.texture
		$Icon.material.set_shader_parameter("disabled", is_checked)
		$Label.text = item.label
		$Label.visible = is_checked


class State extends RefCounted:
	signal updated(item: Item, is_checked: bool)

	const NONE = -1

	var cursor: int = NONE
	var items: Array[Item] = []

	func _init(p_items: Array[Item]) -> void:
		items = p_items

	func cycle_backward() -> void:
		cursor -= 1
		if cursor < NONE:
			cursor = len(items) - 1
		updated.emit(get_item(), cursor > NONE)

	func cycle_forward() -> void:
		cursor += 1
		if cursor >= len(items):
			cursor = NONE
		updated.emit(get_item(), cursor > NONE)

	func get_item() -> Item:
		if items.is_empty():
			return null
		return items.front() if cursor < 0 else items[cursor]

	func reset() -> void:
		cursor = NONE
		updated.emit(get_item(), false)
