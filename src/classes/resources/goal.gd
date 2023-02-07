class_name Goal
extends Resource

@export
var choices: Array[String] = []

var _choice: int = 0


func cycle_backward() -> void:
	_choice = wrapi(_choice - 1, 0, len(choices))
	changed.emit()


func cycle_forward() -> void:
	_choice = wrapi(_choice + 1, 0, len(choices))
	changed.emit()


func get_choice() -> String:
	return "" if choices.is_empty() else choices[_choice]


func reset() -> void:
	_choice = 0
