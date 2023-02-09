extends MarginContainer

@onready
var hint_group_containers: Dictionary = get_meta("hint_group_containers")

var hint_groups: Array[HintGroup]: set = set_hint_groups


func _fill_hint_groups() -> void:
	for group in hint_groups:
		var packed_scene := _get_hint_group_container(group.type)
		if is_instance_valid(packed_scene):
			var node := packed_scene.instantiate()
			$Contents.add_child(node)
			node.owner = self
			node.hint_group = group
		else:
			push_error("Invalid type '%s' for hint group '%s'." % [group.type, group.name])


func _get_hint_group_container(key: String) -> PackedScene:
	return hint_group_containers.get(key)


func request_hint_group_filter_dialog(hint_group_filter: HintGroupFilter, control: Control) -> void:
	$HintFilterPopup.prompt(hint_group_filter, control)


func set_hint_groups(value: Array[HintGroup]) -> void:
	hint_groups = value
	_fill_hint_groups()
