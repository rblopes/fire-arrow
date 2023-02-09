extends "../hint.gd"

@export
var items: Array[Item] = []

@onready
var _state := State.new(items)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_right_button") and not hint.is_pinned():
			removal_requested.emit(hint)
			queue_free()
		elif event.is_action_pressed("ui_mouse_button_cycle_backward"):
			_state.decrease()
		elif event.is_action_pressed("ui_mouse_button_cycle_forward"):
			_state.increase()


func _on_hint_reset() -> void:
	_state.reset()


func _on_state_updated(current_item: Item) -> void:
	if is_instance_valid(current_item):
		%Item.texture = current_item.texture


func _ready() -> void:
	super()
	if is_instance_valid(hint):
		%Symbol.text = hint.get_symbol()
	_state.updated.connect(_on_state_updated)
	_state.reset()


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Item or data is Song or data is Prize


func _drop_data(at_position: Vector2, data: Variant) -> void:
	if is_instance_valid(data):
		%Item.texture = data.texture


func queue_free_on_reset() -> void:
	if not hint.is_pinned():
		queue_free()


func set_hint(value: Hint) -> void:
	if is_instance_valid(value):
		hint = value
		hint.reset.connect(_on_hint_reset)


class State extends RefCounted:
	signal updated(current_item: Item)

	var _cursor: int = 0
	var items: Array[Item] = []

	func _get_item() -> Item:
		return null if items.is_empty() else items[_cursor]

	func _init(p_items: Array[Item]) -> void:
		items = p_items

	func decrease() -> void:
		_cursor = wrapi(_cursor - 1, 0, len(items))
		updated.emit(_get_item())

	func increase() -> void:
		_cursor = wrapi(_cursor + 1, 0, len(items))
		updated.emit(_get_item())

	func reset() -> void:
		_cursor = 0
		updated.emit(_get_item())
