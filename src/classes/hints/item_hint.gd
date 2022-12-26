class_name ItemHint
extends Hint

var symbol: String setget , get_symbol
var location: LocationHint


func get_symbol() -> String:
	return location.symbol if location is LocationHint else ""


func is_pinned() -> bool:
	return pinned


func matches(criteria: String) -> bool:
	return criteria.is_subsequence_ofi(description)


func set_pinned(value: bool) -> void:
	pinned = value


func _to_string() -> String:
	return "[%s] %s" % [get_symbol(), description]
