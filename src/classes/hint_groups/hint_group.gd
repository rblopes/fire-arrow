class_name HintGroup
extends RefCounted

signal hint_added(hint: Hint)
signal hint_removed(hint: Hint)
signal reset()

var bg_color: Color = Color.BLACK
var collection: HintCollection = null
var filtered_flags: int = 0
var flag: int = 0
var hints: Array[Hint] = []
var max_capacity: int = 0
var name: String = ""
var shortcut: Shortcut = null
var type: String = ""


func add_hint(hint: Hint) -> void:
	if not is_full() and is_instance_valid(hint):
		hint.flags |= flag
		hints.append(hint)
		hint_added.emit(hint)


func get_filter() -> HintGroupFilter:
	return HintGroupFilter.new(collection.filter(func(x): return not filtered_flags & x.flags), add_hint)


func is_empty() -> bool:
	return hints.is_empty()


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
		if hints.count(hint) == 0:
			hint.flags &= ~flag
		hint_removed.emit(hint)


func restart() -> void:
	var queue := []
	var i := len(hints)
	while i > 0:
		i -= 1
		var hint := hints[i]
		if hint.is_pinned():
			hint.restart()
		else:
			hint.flags &= ~flag
			queue.append(hint)
	for hint in queue:
		hints.erase(hint)
	reset.emit()
