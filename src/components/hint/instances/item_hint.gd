extends "../hint.gd"

export var item: Resource setget set_item


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_button_cycle_backward"):
			item.cycle_backward()
		if event.is_action_pressed("ui_mouse_button_cycle_forward"):
			item.cycle_forward()


func _on_hint_reset() -> void:
	item.uncheck()


func _on_item_changed() -> void:
	$contents/item.texture = item.get_icon_texture()


func _ready() -> void:
	if is_instance_valid(hint):
		$contents/symbol.text = hint.get_symbol()
	if is_instance_valid(item):
		$contents/item.texture = item.get_icon_texture()


func can_drop_data(at_position: Vector2, data) -> bool:
	return data is Item or data is Song or data is Prize


func drop_data(at_position: Vector2, data) -> void:
	if is_instance_valid(data):
		$contents/item.texture = data.get_icon_texture()


func queue_free_on_reset() -> void:
	if not hint.is_pinned():
		queue_free()


func set_hint(value: ItemHint) -> void:
	if is_instance_valid(value):
		hint = value
		hint.connect("reset", self, "_on_hint_reset")


func set_item(value: Item) -> void:
	if is_instance_valid(value):
		item = value
		item.connect("changed", self, "_on_item_changed")
