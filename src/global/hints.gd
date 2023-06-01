extends Node

var _hints: Array[Hint] = []


func clear() -> void:
	_hints.clear()


func create_counter_hint() -> CounterHint:
	return _add_hint(CounterHint.new())


func create_item_hint() -> ItemHint:
	return _add_hint(ItemHint.new())


func create_special_location_hint() -> SpecialLocationHint:
	return _add_hint(SpecialLocationHint.new())


func filter(predicate: Callable) -> Array[Hint]:
	return _hints.filter(predicate)


func get_pinned_hints() -> Array[Hint]:
	var result: Array[Hint] = []
	result.assign(_hints.filter(func(x): return x.is_pinned()))
	return result


func _add_hint(hint: Hint) -> Hint:
	_hints.append(hint)
	return hint
