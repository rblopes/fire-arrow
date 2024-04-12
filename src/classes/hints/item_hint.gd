class_name ItemHint
extends MiscellaneousHint
## Displays an in-game hint received from a gossip stone, with information about where items and
## songs can be found.

## The locations this hint refers to. The symbol of the first location is displayed beside its description.
var locations: Array[LocationHint] = []

## Which placeholders to display inside this hint.
var icons: Array[StringName] = []


func _to_string() -> String:
	return "[%s] %s" % [get_symbol(), description]


func get_symbol() -> String:
	if locations.is_empty() or not is_instance_valid(locations.front()):
		return LocationHint.UNDEFINED_SYMBOL
	return locations.front().symbol


func is_pinned() -> bool:
	return pinned


func matches(criteria: String) -> bool:
	return criteria.is_subsequence_ofn(description)


func set_pinned(value: bool) -> void:
	pinned = value
