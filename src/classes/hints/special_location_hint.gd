class_name SpecialLocationHint
extends Hint

signal changed()

var choices: Array[Hint]

var location: LocationHint:
	set = set_location

var shortcut: Shortcut


func get_filter() -> HintGroupFilter:
	return HintGroupFilter.new(choices, set_location)


func get_symbol() -> String:
	return location.symbol if is_instance_valid(location) else "N/D"


func is_pinned() -> bool:
	return true


func restart() -> void:
	self.location = null


func set_location(value: LocationHint) -> void:
	if value != location:
		location = value
		changed.emit()
