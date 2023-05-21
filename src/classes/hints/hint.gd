class_name Hint
extends RefCounted

var description: String:
	set(value):
		description = value.strip_edges()

var flags: int

var pinned: bool:
	get = is_pinned,
	set = set_pinned


func _to_string() -> String:
	return description


func is_pinned() -> bool:
	return false


func matches(criteria: String) -> bool:
	return false


func set_pinned(value: bool) -> void:
	pass
