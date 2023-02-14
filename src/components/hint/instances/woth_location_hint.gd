extends "../hint.gd"


func _can_drop_data(at_position: Vector2, data) -> bool:
	return data is Item or data is Song or data is Prize


func _drop_data(at_position: Vector2, data) -> void:
	%ItemTray.add_item_icon(data)
