class_name Hint
extends Reference

signal reset()

var description: String setget set_description
var flags: int
var pinned: bool setget set_pinned, is_pinned


func _to_string() -> String:
	return description


func is_pinned() -> bool:
	return false


func matches(criteria: String) -> bool:
	return false


func reset() -> void:
	emit_signal("reset")


func set_description(value: String) -> void:
	description = value.strip_edges()


func set_pinned(value: bool) -> void:
	pass
