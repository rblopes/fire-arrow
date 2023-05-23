extends VBoxContainer

@onready
var _hint_group_scenes: Dictionary = get_meta("hint_group_scenes")


func add_hint_group(hint_group: HintGroup) -> void:
	if is_instance_valid(hint_group):
		var node := _instantiate_hint_group_container(hint_group)
		node.hint_group = hint_group
		add_child(node)


func _get_hint_group_scene_of_type(type: String) -> PackedScene:
	return _hint_group_scenes.get(type)


func _instantiate_hint_group_container(hint_group: HintGroup) -> PanelContainer:
	var packed_scene := _get_hint_group_scene_of_type(hint_group.type)
	assert(is_instance_valid(packed_scene), "Invalid type '%s' for hint group '%s'." % [hint_group.type, hint_group.name])
	return packed_scene.instantiate()
