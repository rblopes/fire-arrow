class_name HintCollection
extends Node

var _hints: Array[Hint] = []

@export
var is_locked: bool = false


func add_hint(hint: Hint) -> void:
	if not is_locked and is_instance_valid(hint):
		_hints.append(hint)


func filter(predicate: Callable) -> Array[Hint]:
	return _hints.filter(predicate)


func set_hints(hints: Array[Hint]) -> void:
	if hints.all(func(x): return is_instance_valid(x)):
		_hints.assign(hints)
