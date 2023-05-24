class_name MiscellaneousHintGroup
extends HintGroup


func add_hint(hint: Hint) -> void:
	if not is_full() and is_instance_valid(hint):
		hints.append(hint)
		hint_added.emit(hint)


func is_full() -> bool:
	var result := max_capacity
	var i := len(hints)
	while result > 0 and i > 0:
		i -= 1
		result -= int(not hints[i].is_pinned())
	return result <= 0


func remove_hint(hint: Hint) -> void:
	if is_instance_valid(hint) and hint in hints:
		hints.erase(hint)
		hint_removed.emit(hint)


func clear() -> void:
	var queue := []
	var i := len(hints)
	while i > 0:
		i -= 1
		var hint := hints[i]
		if hint.is_pinned():
			hint.restart()
		else:
			queue.append(hint)
	for hint in queue:
		hints.erase(hint)
	cleared.emit()


func _get_filter_helper() -> Array[Hint]:
	return collection.filter(func(x): return not x in hints and (x is ItemHint and not x.location.is_barren()))
