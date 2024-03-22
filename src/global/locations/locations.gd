extends Node

@onready
var _locations_data: JSON = get_meta("locations_data")

@onready
var _locations := _setup_locations(_locations_data.data)


func clear_all() -> void:
	for location in _locations.values():
		location.clear_flags()


func get_without_flags(flags: int) -> Array[Hint]:
	var result: Array[Hint] = []
	for location in _locations.values():
		if not location.has_flags(flags):
			result.append(location)
	return result


func find_by_symbol(symbol: String) -> LocationHint:
	return _locations.get(symbol)


func _setup_locations(data: Array) -> Dictionary:
	var result := {}
	for location_data: Dictionary in data:
		var location := LocationHint.from_dict(location_data)
		result[location.symbol] = location
	return result
