class_name CounterHint
extends Hint

signal changed()

const INCREMENT_BY := 1
const MAX_VALUE := 100
const MIN_VALUE := 0

var increment_by: int = INCREMENT_BY
var max_value: int = MAX_VALUE
var min_value: int = MIN_VALUE
var value: int = min_value


func decrease() -> void:
	value = int(max(min_value, value - increment_by))
	emit_signal("changed")


func get_formatted_count(mask: String = "%02d") -> String:
	return mask % [value]


func increase() -> void:
	value = int(min(max_value, value + increment_by))
	emit_signal("changed")


func is_pinned() -> bool:
	return true


func reset() -> void:
	value = min_value
	emit_signal("changed")
