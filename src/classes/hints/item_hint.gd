class_name ItemHint
extends Hint

var location: LocationHint


func get_symbol() -> String:
	return location.symbol if is_instance_valid(location) else ""


func is_pinned() -> bool:
	return pinned


func matches(criteria: String) -> bool:
	return criteria.is_subsequence_ofn(description)


func set_pinned(value: bool) -> void:
	pinned = value


func _to_string() -> String:
	return "[%s] %s" % [get_symbol(), description]
