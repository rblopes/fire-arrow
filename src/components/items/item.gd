extends Control

@export
var items: Array[Item] = []

@onready
var _state := State.new(items)


func _get_drag_data(at_position: Vector2) -> Variant:
	return UiHelper.set_icon_drag_preview_for(self, _state.get_item())


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_released("ui_mouse_button_cycle_backward"):
			_state.decrease()
		if event.is_action_released("ui_mouse_button_cycle_forward"):
			_state.increase()


func _on_state_updated(current_item: Item, is_dimmed: bool) -> void:
	if is_instance_valid(current_item):
		$Icon.texture = current_item.texture
		$Icon.material.set_shader_parameter("disabled", not is_dimmed)
		$Label.text = current_item.label
		$Label.visible = not is_dimmed


func _ready() -> void:
	_state.updated.connect(_on_state_updated)
	reset()


func reset() -> void:
	_state.reset()


class State extends RefCounted:
	signal updated(current_item: Item, is_dimmed: bool)

	var cursor: int = 0
	var is_dimmed: bool = true
	var items: Array[Item] = []

	func _init(p_items: Array[Item]) -> void:
		items = p_items

	func decrease() -> void:
		if not is_dimmed and cursor == 0:
			is_dimmed = true
		else:
			cursor = wrapi(cursor - 1, 0, len(items))
			is_dimmed = false
		updated.emit(get_item(), is_dimmed)

	func get_item() -> Item:
		return null if items.is_empty() else items[cursor]

	func increase() -> void:
		if is_dimmed:
			is_dimmed = false
		else:
			cursor = wrapi(cursor + 1, 0, len(items))
			is_dimmed = cursor == 0
		updated.emit(get_item(), is_dimmed)

	func reset() -> void:
		cursor = 0
		is_dimmed = true
		updated.emit(get_item(), is_dimmed)
