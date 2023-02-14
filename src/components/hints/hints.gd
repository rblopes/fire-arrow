extends MarginContainer

@onready
var _hint_group_scenes: Dictionary = get_meta("hint_group_containers")


func _get_hint_group_scene(key: String) -> PackedScene:
	return _hint_group_scenes.get(key)


func _on_hint_filter_requested(hint_group_filter: HintGroupFilter, host_control: Control) -> void:
	$HintFilterPopup.prompt(hint_group_filter, host_control)


func reset() -> void:
	get_tree().call_group("hints", "reset")


func set_hint_groups(hint_groups: Array[HintGroup]) -> void:
	for hint_group in hint_groups:
		var packed_scene := _get_hint_group_scene(hint_group.type)
		assert(is_instance_valid(packed_scene), "Invalid type '%s' for hint group '%s'." % [hint_group.type, hint_group.name])
		var node := packed_scene.instantiate()
		node.hint_filter_requested.connect(_on_hint_filter_requested)
		$Contents.add_child(node)
		node.owner = self
		node.set_hint_group(hint_group)
