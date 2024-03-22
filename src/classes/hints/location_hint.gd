class_name LocationHint
extends Hint
## An in-game location, and its symbol.

## Special bit-flags, used for filtering.
enum Flags {
	NONE = 0x0,                            ## None.
	BARREN = 0x1,                          ## Barren location.
	GOAL1 = 0x2,                           ## Goal 1.
	GOAL2 = 0x4,                           ## Goal 2.
	GOAL3 = 0x8,                           ## Goal 3.
	MAX = BARREN | GOAL1 | GOAL2 | GOAL3,  ## Maximum allowed value.
}

## A symbol representing an undefined location.
const UNDEFINED_SYMBOL: String = "N/D"

## A bit-flag field, used for filtering.
var flags: int:
	set(value):
		flags = value & Flags.MAX

## This location's symbol: a unique 3-letter abbreviation, shown in item hints, inline location
## groups and others.
var symbol: String = UNDEFINED_SYMBOL


static func from_dict(dict: Dictionary) -> LocationHint:
	var result := new()
	result.description = dict.get("description")
	result.symbol = dict.get("symbol")
	return result


## Clears the given bits of [member flags].
func clear_flags(bits: int = Flags.MAX) -> void:
	flags &= ~bits


## Checks if bits have been applied to [member flags].
func has_flags(bits: int) -> bool:
	return bool(flags & bits)


## Answers whether this location is deemed barren or not.
func is_barren() -> bool:
	return has_flags(Flags.BARREN)


## Compares this location symbol to a given user input.
func matches(value: String) -> bool:
	return value.is_subsequence_ofn(symbol)


## Applies the given bits to [member flags].
func set_flags(bits: int) -> void:
	flags |= bits


func _to_string() -> String:
	return description
