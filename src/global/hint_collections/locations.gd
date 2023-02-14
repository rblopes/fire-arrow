extends HintCollection

var _locations: Dictionary = {
	"BOTW": LocationHint.new("BOTW", "Bottom of the Well"),
	"DMC": LocationHint.new("DMC", "Death Mountain Crater"),
	"DMT": LocationHint.new("DMT", "Death Mountain Trail"),
	"COL": LocationHint.new("COL", "Desert Colossus"),
	"DC": LocationHint.new("DC", "Dodongo's Cavern"),
	"FIR": LocationHint.new("FIR", "Fire Temple"),
	"FOR": LocationHint.new("FOR", "Forest Temple"),
	"GTG": LocationHint.new("GTG", "Gerudo Training Ground"),
	"GV": LocationHint.new("GV", "Gerudo Valley"),
	"GF": LocationHint.new("GF", "Gerudo's Fortress"),
	"GC": LocationHint.new("GC", "Goron City"),
	"GY": LocationHint.new("GY", "Graveyard"),
	"HW": LocationHint.new("HW", "Haunted Wasteland"),
	"HC": LocationHint.new("HC", "Hyrule Castle"),
	"HF": LocationHint.new("HF", "Hyrule Field"),
	"IC": LocationHint.new("IC", "Ice Cavern"),
	"GAN": LocationHint.new("GAN", "Inside Ganon's Castle"),
	"JJ": LocationHint.new("JJ", "Inside Jabu-Jabu's Belly"),
	"DKT": LocationHint.new("DKT", "Inside the Deku Tree"),
	"KAK": LocationHint.new("KAK", "Kakariko Village"),
	"KF": LocationHint.new("KF", "Kokiri Forest"),
	"LH": LocationHint.new("LH", "Lake Hylia"),
	"LLR": LocationHint.new("LLR", "Lon Lon Ranch"),
	"LW": LocationHint.new("LW", "Lost Woods"),
	"MKT": LocationHint.new("MKT", "Market"),
	"OGC": LocationHint.new("OGC", "Outside Ganon's Castle"),
	"SFM": LocationHint.new("SFM", "Sacred Forest Meadow"),
	"SHA": LocationHint.new("SHA", "Shadow Temple"),
	"SPI": LocationHint.new("SPI", "Spirit Temple"),
	"TOT": LocationHint.new("TOT", "Temple of Time"),
	"WAT": LocationHint.new("WAT", "Water Temple"),
	"ZD": LocationHint.new("ZD", "Zora's Domain"),
	"ZF": LocationHint.new("ZF", "Zora's Fountain"),
	"ZR": LocationHint.new("ZR", "Zora's River"),
}


func _enter_tree() -> void:
	_hints.assign(_locations.values())


func find_by_symbol(symbol: String) -> LocationHint:
	return _locations.get(symbol)
