extends MarginContainer


func add_hint_groups(hint_groups: Array[HintGroup]) -> void:
	for hint_group in hint_groups:
		$Contents.add_hint_group(hint_group)


func reset() -> void:
	get_tree().call_group("hints", "reset")


func _on_contents_child_entered_tree(node: Node) -> void:
	node.owner = self
	node.hint_filter_requested.connect(_on_hint_filter_requested)


func _on_hint_filter_requested(hint_group_filter: HintGroupFilter, host_control: Control) -> void:
	$HintFilterPopup.prompt(hint_group_filter, host_control)
