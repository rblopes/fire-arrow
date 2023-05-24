class_name ItemHint
extends MiscellaneousHint
## Displays an in-game hint received from a gossip stone, with information about where items and
## songs can be found.

## The location of this hint, displayed by the tracker as its symbol beside the description.
var location: LocationHint

## How many placeholders to display inside this hint.
var icons: int = 1:
	set(value):
		icons = clampi(value, 1, 3)


func _to_string() -> String:
	return "[%s] %s" % [get_symbol(), description]


func get_symbol() -> String:
	return location.symbol if is_instance_valid(location) else LocationHint.UNDEFINED_SYMBOL


func is_pinned() -> bool:
	return pinned


func matches(criteria: String) -> bool:
	return criteria.is_subsequence_ofn(description)


func set_pinned(value: bool) -> void:
	pinned = value
