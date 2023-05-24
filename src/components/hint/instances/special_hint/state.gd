extends Node

signal updated(symbol: String)

var _location: LocationHint = null
var hint: SpecialLocationHint = null


func _get_symbol() -> String:
	return _location.symbol if is_instance_valid(_location) else LocationHint.UNDEFINED_SYMBOL


func _set_location(p_location: LocationHint) -> void:
	_location = p_location
	updated.emit(_get_symbol())


func get_filter() -> HintGroupFilter:
	return HintGroupFilter.new(hint.choices, _set_location)


func reset() -> void:
	_set_location(null)
