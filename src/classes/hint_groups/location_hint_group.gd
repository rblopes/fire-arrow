class_name LocationHintGroup
extends HintGroup

var filtered_flags: int = 0
var applied_flag: int = 0


func add_hint(hint: Hint) -> void:
	if is_instance_valid(hint) and not is_full():
		hint.set_flags(applied_flag)
		hints.append(hint)
		hint_added.emit(hint)


func is_full() -> bool:
	return len(hints) >= max_capacity


func remove_hint(hint: Hint) -> void:
	if is_instance_valid(hint) and hint in hints:
		hints.erase(hint)
		if hints.count(hint) == 0:
			hint.clear_flags(applied_flag)
		hint_removed.emit(hint)


func clear() -> void:
	for hint in hints:
		hint.clear_flags(applied_flag)
	hints.clear()
	cleared.emit()


func _get_filter_helper() -> Array[Hint]:
	return collection.filter(func(x): return not x.has_flags(filtered_flags))
