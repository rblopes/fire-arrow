extends HBoxContainer

@onready
var item_icon_scene: PackedScene = get_meta("item_icon_scene")


func _get_item_from(data: Variant) -> Item:
	var result := Item.new()
	if data is Item:
		result.icons = [data.get_selected_icon()]
	if data is Song or data is Prize:
		result.icons = [data.icon]
	return result


func _on_item_icon_gui_input(event: InputEvent, node: TextureRect) -> void:
	if event.is_action_pressed("ui_mouse_right_button"):
		node.queue_free()


func add_item_icon(data: Variant) -> void:
	var node: TextureRect = item_icon_scene.instantiate()
	node.gui_input.connect(_on_item_icon_gui_input.bind(node))
	node.item = _get_item_from(data)
	add_child(node)
