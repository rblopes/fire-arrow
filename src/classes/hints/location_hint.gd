class_name LocationHint
extends Hint

var symbol: String


func _init(p_symbol: String = "", p_description: String = "") -> void:
	symbol = p_symbol
	description = p_description


func matches(criteria: String) -> bool:
	return criteria.is_subsequence_ofn(symbol)
