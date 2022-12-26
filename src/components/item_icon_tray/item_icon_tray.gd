extends HBoxContainer

export var item_icon_scene: PackedScene


func add_item_icon(data) -> void:
	var node: TextureRect = item_icon_scene.instance()
	node.connect("gui_input", self, "_on_item_icon_gui_input", [node])
	node.item = get_item_from(data)
	add_child(node)


func get_item_from(data) -> Item:
	var result := Item.new()
	match data.get_script():
		Item:
			result.icons = [data.get_selected_icon()]
		Song, Prize:
			result.icons = [data.icon]
	return result


func _on_item_icon_gui_input(event: InputEvent, node: TextureRect) -> void:
	if event.is_action_pressed("ui_mouse_right_button"):
		node.queue_free()
