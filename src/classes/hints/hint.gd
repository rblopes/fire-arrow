class_name Hint
extends RefCounted

signal reset()

var description: String:
	set = set_description

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


func restart() -> void:
	reset.emit()


func set_description(value: String) -> void:
	description = value.strip_edges()


func set_pinned(value: bool) -> void:
	pass
