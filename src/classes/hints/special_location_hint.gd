class_name SpecialLocationHint
extends Hint

signal changed()

var choices: Array
var location: LocationHint setget set_location
var shortcut: ShortCut


func get_filter() -> HintGroupFilter:
	return HintGroupFilter.new(choices, funcref(self, "set_location"))


func get_symbol() -> String:
	return location.symbol if location is LocationHint else "N/D"


func is_pinned() -> bool:
	return true


func reset() -> void:
	self.location = null


func set_location(value: LocationHint) -> void:
	if value != location:
		location = value
		emit_signal("changed")
