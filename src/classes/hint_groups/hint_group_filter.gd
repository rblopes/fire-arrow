class_name HintGroupFilter
extends RefCounted

var select_callback: Callable
var hints: Array[Hint]


func _init(p_hints: Array[Hint], p_select_callback: Callable) -> void:
	hints = p_hints
	select_callback = p_select_callback


func filter(value: String = "") -> Array[Hint]:
	return hints.filter(func(hint: Hint) -> bool: return is_instance_valid(hint) and hint.matches(value))


func select(hint: Hint) -> void:
	if is_instance_valid(hint) and select_callback.is_valid():
		select_callback.call(hint)
