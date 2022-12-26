extends "../hint.gd"


func can_drop_data(at_position: Vector2, data) -> bool:
	return data is Item or data is Song or data is Prize


func drop_data(at_position: Vector2, data) -> void:
	$contents/item_tray.add_item_icon(data)


func queue_free_on_reset() -> void:
	queue_free()
