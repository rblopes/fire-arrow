extends "../hint.gd"

@export
var item: Item:
	set(value):
		if is_instance_valid(value):
			item = value
			item.changed.connect(_on_item_changed)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouse_right_button"):
			removal_requested.emit(hint)
			queue_free()
		elif event.is_action_pressed("ui_mouse_button_cycle_backward"):
			item.cycle_backward()
		elif event.is_action_pressed("ui_mouse_button_cycle_forward"):
			item.cycle_forward()


func _on_hint_reset() -> void:
	item.uncheck()


func _on_item_changed() -> void:
	%Item.texture = item.get_icon_texture()


func _ready() -> void:
	super()
	if is_instance_valid(hint):
		%Symbol.text = hint.get_symbol()
	if is_instance_valid(item):
		%Item.texture = item.get_icon_texture()


func _can_drop_data(at_position: Vector2, data) -> bool:
	return data is Item or data is Song or data is Prize


func _drop_data(at_position: Vector2, data) -> void:
	if is_instance_valid(data):
		%Item.texture = data.get_icon_texture()


func queue_free_on_reset() -> void:
	if not hint.is_pinned():
		queue_free()


func set_hint(value: Hint) -> void:
	if is_instance_valid(value):
		hint = value
		hint.reset.connect(_on_hint_reset)
