class_name HintGroup
extends Reference

signal hint_added(hint)
signal hint_removed(hint)
signal reset()

var hints: Array
var bg_color: Color
var collection: Node
var filtered_flags: int
var flag: int
var max_capacity: int
var name: String
var shortcut: ShortCut
var type: String


func add_hint(hint: Hint) -> void:
	if is_full():
		return
	if is_instance_valid(hint):
		hint.flags |= flag
		hints.append(hint)
		emit_signal("hint_added", hint)


func get_filter() -> HintGroupFilter:
	var result := []
	for hint in collection.get_hints():
		if filtered_flags & hint.flags:
			continue
		result.append(hint)
	return HintGroupFilter.new(result, funcref(self, "add_hint"))


func is_empty() -> bool:
	return hints.empty()


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
		emit_signal("hint_removed", hint)


func reset() -> void:
	var queue := []
	var i := len(hints)
	while i > 0:
		i -= 1
		var hint: Hint = hints[i]
		if hint.is_pinned():
			hint.reset()
		else:
			hint.flags &= ~flag
			queue.append(hint)
	for hint in queue:
		hints.erase(hint)
	emit_signal("reset")
