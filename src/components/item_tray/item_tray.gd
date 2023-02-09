extends HBoxContainer

@onready
var item_tray_icon_scene: PackedScene = get_meta("item_tray_icon_scene")


func add_item_icon(data: Variant) -> void:
	if is_instance_valid(data):
		var node: Button = item_tray_icon_scene.instantiate()
		node.icon = data.texture
		add_child(node)
