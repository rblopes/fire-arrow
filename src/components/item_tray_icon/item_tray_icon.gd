extends Button


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Item or data is Prize or data is Song


func _drop_data(at_position: Vector2, data: Variant) -> void:
	icon = data.texture


func _pressed() -> void:
	queue_free()
