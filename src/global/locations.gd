extends Node

var _locations := {}


func _ready() -> void:
	_add_location("BTW", "Bottom of the Well")
	_add_location("DMC", "Death Mountain Crater")
	_add_location("DMT", "Death Mountain Trail")
	_add_location("COL", "Desert Colossus")
	_add_location("DC", "Dodongo's Cavern")
	_add_location("FIR", "Fire Temple")
	_add_location("FOR", "Forest Temple")
	_add_location("GTG", "Gerudo Training Ground")
	_add_location("GV", "Gerudo Valley")
	_add_location("GF", "Gerudo's Fortress")
	_add_location("GC", "Goron City")
	_add_location("GY", "Graveyard")
	_add_location("HW", "Haunted Wasteland")
	_add_location("HC", "Hyrule Castle")
	_add_location("HF", "Hyrule Field")
	_add_location("IC", "Ice Cavern")
	_add_location("GAN", "Inside Ganon's Castle")
	_add_location("JJ", "Inside Jabu-Jabu's Belly")
	_add_location("DKT", "Inside the Deku Tree")
	_add_location("KAK", "Kakariko Village")
	_add_location("KF", "Kokiri Forest")
	_add_location("LH", "Lake Hylia")
	_add_location("LLR", "Lon Lon Ranch")
	_add_location("LW", "Lost Woods")
	_add_location("MKT", "Market")
	_add_location("OGC", "Outside Ganon's Castle")
	_add_location("SFM", "Sacred Forest Meadow")
	_add_location("SHA", "Shadow Temple")
	_add_location("SPI", "Spirit Temple")
	_add_location("TOT", "Temple of Time")
	_add_location("WAT", "Water Temple")
	_add_location("ZD", "Zora's Domain")
	_add_location("ZF", "Zora's Fountain")
	_add_location("ZR", "Zora's River")


func clear_all() -> void:
	for location in _locations.values():
		location.clear_flags()


func get_without_flags(flags: int) -> Array[Hint]:
	var result: Array[Hint] = []
	result.assign(_locations.values().filter(func(x): return not x.has_flags(flags)))
	return result


func find_by_symbol(symbol: String) -> LocationHint:
	return _locations.get(symbol)


func _add_location(p_symbol: String, p_name: String) -> void:
	_locations[p_symbol] = LocationHint.new(p_symbol, p_name)
