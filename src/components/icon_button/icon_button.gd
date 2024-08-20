extends Button

enum IconType {
	ITEM = 0x01,
	PRIZE = 0x02,
	SONG = 0x04,
}

@export
var items: Array[Resource] = []:
	set(value):
		assert(len(value) > 0)
		items = value.duplicate()

@export_flags("Items", "Prizes", "Songs")
var allowed_icon_types: int = 0

var _cursor: int = 0:
	set(value):
		_cursor = value
		icon = items[_cursor].texture


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var can_drop_item := data is Item and bool(allowed_icon_types & IconType.ITEM)
	var can_drop_prize := data is Prize and bool(allowed_icon_types & IconType.PRIZE)
	var can_drop_song := data is Song and bool(allowed_icon_types & IconType.SONG)
	return can_drop_item or can_drop_prize or can_drop_song


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
