extends Node

var tracker_layout: TrackerLayout


func get_collection(collection_name: String) -> Node:
	return get_node_or_null(collection_name)


func reset() -> void:
	$Groups.reset()


func setup_hints(p_tracker_layout: TrackerLayout) -> void:
	tracker_layout = p_tracker_layout
	$Groups.hint_groups = tracker_layout.groups
	$Groups.init_hint_groups()
