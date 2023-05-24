class_name MiscellaneousHint
extends Hint
## Base class for in-game hints.

var pinned: bool:
	get = is_pinned,
	set = set_pinned


func is_pinned() -> bool:
	return true


func set_pinned(value: bool) -> void:
	pass
