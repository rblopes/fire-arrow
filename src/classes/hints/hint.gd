class_name Hint
extends RefCounted
## Base class for all hints displayed by the tracker.

var description: String:
	set(value):
		description = value.strip_edges()


func matches(value: String) -> bool:
	return false
