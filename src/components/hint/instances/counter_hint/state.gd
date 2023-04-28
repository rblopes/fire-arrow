extends Node

signal updated(formatted_count: String)

var count: int = 0
var hint: CounterHint = null:
	set(value):
		if is_instance_valid(value):
			hint = value
			count = hint.min_value


func _get_formatted_count(mask: String = "%02d") -> String:
	return mask % [count]


func decrease() -> void:
	count = int(max(hint.min_value, count - hint.increment_by))
	updated.emit(_get_formatted_count())


func increase() -> void:
	count = int(min(hint.max_value, count + hint.increment_by))
	updated.emit(_get_formatted_count())


func reset() -> void:
	count = hint.min_value
	updated.emit(_get_formatted_count())
