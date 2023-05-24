extends Node


func load_layout(file_path: String) -> TrackerLayout:
	var result := parse_layout_data(JsonFile.load_json(file_path, {}))
	result.file_path = file_path
	return result


func parse_counter_params(params: Dictionary) -> CounterHint:
	var result := CounterHint.new()
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
	var result := ItemHint.new()
	for key in params:
		var value = params.get(key)
		match key:
			"description":
				if value is String:
					result.description = value.strip_edges()
			"icons":
				if value is float:
					result.icons = int(value)
			"is_pinned":
				if value is bool:
					result.pinned = value
			"symbol":
				if value is String:
					var hint_collection := HintCollections.fetch("Locations")
					result.location = hint_collection.find_by_symbol(value.strip_edges())
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
					HintCollections.fetch("Hints").set_hints(result.hints)
	return result


func parse_location_hint_group_params(params: Dictionary) -> LocationHintGroup:
	var result := LocationHintGroup.new(HintCollections.fetch("Locations"))
	for key in params:
		var value = params.get(key)
		match key:
			"applied_flag":
				if value is float:
					result.applied_flag = int(value)
			"background_color":
				if value is String and value.is_valid_html_color():
					result.background_color = Color(value)
			"capacity":
				if value is float:
					result.max_capacity = int(value)
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
	var result := MiscellaneousHintGroup.new(HintCollections.fetch("Hints"))
	for key in params:
		var value = params.get(key)
		match key:
			"background_color":
				if value is String and value.is_valid_html_color():
					result.background_color = Color(value)
			"capacity":
				if value is float:
					result.max_capacity = int(value)
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
	var result := SpecialLocationHint.new()
	for key in params:
		var value = params.get(key)
		match key:
			"choices":
				if value is String:
					var hint_collection := HintCollections.fetch("Locations")
					for choice in value.strip_edges().split(";"):
						result.choices.append(hint_collection.find_by_symbol(choice))
			"description":
				if value is String:
					result.description = value.strip_edges()
			"shortcut":
				if value is String:
					result.shortcut = UiHelper.get_shortcut(value.strip_edges())
	return result
