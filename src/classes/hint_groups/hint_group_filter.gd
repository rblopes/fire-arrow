class_name HintGroupFilter
extends Reference

var select_callback: FuncRef
var hints: Array


func _init(p_hints: Array, p_select_callback: FuncRef) -> void:
	select_callback = p_select_callback
	hints = p_hints


func filter(value: String = "") -> Array:
	var result := []
	for hint in hints:
		if hint is Hint and hint.matches(value):
			result.append(hint)
	return result


func select(hint: Hint) -> void:
	if is_instance_valid(hint) and select_callback.is_valid():
		select_callback.call_func(hint)
