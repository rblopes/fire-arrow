extends Node

signal loaded(tracker_layout: TrackerLayout)

@onready
var _modes: Dictionary = get_meta("modes")


func get_builtin_presets_info() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for key in _modes:
		var preset: JSON = _modes[key]
		result.append({"preset_name": key, "title": preset.data.get("title")})
	return result


func load_builtin_layout(layout_name: String) -> void:
	var data = _get_builtin_layout(layout_name).data
	Locations.clear_all()
	Hints.clear()
	loaded.emit(parse_layout_data(data))


func load_layout_from_file(file_path: String) -> void:
	Locations.clear_all()
	Hints.clear()
	var result := parse_layout_data(JsonFile.load_json(file_path, {}))
	result.file_path = file_path
	loaded.emit(result)


func parse_counter_params(params: Dictionary) -> CounterHint:
	var result := Hints.create_counter_hint()
	for key in params:
		var value = params.get(key)
		match key:
			"description":
				if value is String:
					result.description = value.strip_edges()
			"increment_by":
				if value is float:
					result.increment_by = int(value)
			"max_value":
				if value is float:
					result.max_value = int(value)
			"min_value":
				if value is float:
					result.min_value = int(value)
	return result


func parse_hint_groups(data: Array) -> Array[HintGroup]:
	var result: Array[HintGroup] = []
	for params in data:
		match params:
			{"type": "locations", "properties": var properties}:
				result.append(parse_location_hint_group_params(properties))
			{"type": "miscellaneous", "properties": var properties}:
				result.append(parse_miscellaneous_hint_group_params(properties))
	return result


func parse_hints(data: Array) -> Array[Hint]:
	var result: Array[Hint] = []
	for hint_data in data:
		match hint_data:
			{"type": "counter", "params": var params}:
				result.append(parse_counter_params(params))
			{"type": "item", "params": var params}:
				result.append(parse_item_params(params))
			{"type": "special_location", "params": var params}:
				result.append(parse_special_location_params(params))
	return result


func parse_item_params(params: Dictionary) -> ItemHint:
	var result := Hints.create_item_hint()
	for key in params:
		var value = params.get(key)
		match key:
			"description":
				if value is String:
					result.description = value.strip_edges()
			"icons":
				if value is Array:
					result.icons.assign(value)
			"is_pinned":
				if value is bool:
					result.pinned = value
			"locations":
				if value is Array:
					result.locations.append_array(value.map(func(s: String): return Locations.find_by_symbol(s.strip_edges())))
	return result


func parse_layout_data(data: Dictionary) -> TrackerLayout:
	var result := TrackerLayout.new()
	for key in data:
		var value = data.get(key)
		match key:
			"groups":
				if value is Array:
					result.groups = parse_hint_groups(value)
			"hints":
				if value is Array:
					result.hints = parse_hints(value)
			"title":
				if value is String:
					result.title = value
	return result


func parse_location_hint_group_params(params: Dictionary) -> LocationHintGroup:
	var result := LocationHintGroup.new()
	for key in params:
		var value = params.get(key)
		match key:
			"applied_flag":
				if value is float:
					result.applied_flag = int(value)
			"capacity":
				if value is float:
					result.max_capacity = int(value)
			"color":
				if value is String and value.is_valid_html_color():
					result.color = Color(value)
			"filtered_flags":
				if value is float:
					result.filtered_flags = int(value)
			"name":
				if value is String:
					result.name = value.strip_edges()
			"shortcut":
				if value is String:
					result.shortcut = UiHelper.get_shortcut(value.strip_edges())
			"style":
				if value is String:
					result.style = value.strip_edges()
	return result


func parse_miscellaneous_hint_group_params(params: Dictionary) -> MiscellaneousHintGroup:
	var result := MiscellaneousHintGroup.new()
	for key in params:
		var value = params.get(key)
		match key:
			"capacity":
				if value is float:
					result.max_capacity = int(value)
			"color":
				if value is String and value.is_valid_html_color():
					result.color = Color(value)
			"name":
				if value is String:
					result.name = value.strip_edges()
			"shortcut":
				if value is String:
					result.shortcut = UiHelper.get_shortcut(value.strip_edges())
			"style":
				if value is String:
					result.style = value.strip_edges()
	return result


func parse_special_location_params(params: Dictionary) -> SpecialLocationHint:
	var result := Hints.create_special_location_hint()
	for key in params:
		var value = params.get(key)
		match key:
			"choices":
				if value is String:
					for choice in value.strip_edges().split(";"):
						result.choices.append(Locations.find_by_symbol(choice))
			"description":
				if value is String:
					result.description = value.strip_edges()
			"shortcut":
				if value is String:
					result.shortcut = UiHelper.get_shortcut(value.strip_edges())
	return result


func _get_builtin_layout(layout_name: String) -> JSON:
	assert(layout_name in _modes, "Invalid preset name")
	return _modes.get(layout_name)
