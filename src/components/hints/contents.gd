extends VBoxContainer

@onready
var _hint_group_scenes: Dictionary = get_meta("hint_group_scenes")


func add_hint_group(hint_group: HintGroup) -> void:
	if is_instance_valid(hint_group):
		var node := _instantiate_hint_group_container(hint_group)
		node.hint_group = hint_group
		add_child(node)


func _get_hint_group_scene_of_style(style: String) -> PackedScene:
	return _hint_group_scenes.get(style)


func _instantiate_hint_group_container(hint_group: HintGroup) -> PanelContainer:
	var packed_scene := _get_hint_group_scene_of_style(hint_group.style)
	assert(is_instance_valid(packed_scene), "Invalid style '%s' for hint group '%s'." % [hint_group.style, hint_group.name])
	return packed_scene.instantiate()
