extends Node

var hint_groups: Array


func init_hint_groups() -> void:
	for hint_group in hint_groups:
		var collection = owner.get_collection(hint_group.get_meta("collection", ""))
		if collection is Node:
			hint_group.collection = collection
			for hint in collection.get_hints():
				if hint.is_pinned():
					hint_group.add_hint(hint)


func reset() -> void:
	for hint_group in hint_groups:
		hint_group.reset()
