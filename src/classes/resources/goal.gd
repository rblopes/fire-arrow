class_name Goal
extends Resource

export(Array, String) var choices: Array
var _choice: int = 0


func cycle_backward() -> void:
	_choice = wrapi(_choice - 1, 0, len(choices))
	emit_changed()


func cycle_forward() -> void:
	_choice = wrapi(_choice + 1, 0, len(choices))
	emit_changed()


func get_choice() -> String:
	return choices[_choice]
