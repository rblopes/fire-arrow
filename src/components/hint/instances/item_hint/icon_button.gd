extends Button

var _cursor: int = 0:
	set(value):
		_cursor = value
		icon = items[_cursor].texture

var items: Array[Resource] = []:
	set(value):
		assert(len(value) > 0)
		items = value


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return is_instance_valid(data) and (data is Item or data is Song)


func _drop_data(at_position: Vector2, data: Variant) -> void:
	_cursor = 0
	icon = data.texture


func _pressed() -> void:
	cycle_forward()


func cycle_backward() -> void:
	_cursor = wrapi(_cursor - 1, 0, len(items))


func cycle_forward() -> void:
	_cursor = wrapi(_cursor + 1, 0, len(items))


func set_icon(data: Variant = null) -> void:
	_cursor = 0
	if is_instance_valid(data) and (data is Item or data is Song):
		icon = data.texture
