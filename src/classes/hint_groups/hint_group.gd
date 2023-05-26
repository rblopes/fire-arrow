class_name HintGroup
extends RefCounted

signal hint_added(hint: Hint)
signal hint_removed(hint: Hint)
signal cleared()

var collection: HintCollection = null
var color: Color = Color.BLACK
var hints: Array[Hint] = []
var max_capacity: int = 0
var name: String = ""
var shortcut: Shortcut = null
var style: String = ""


func _init(p_collection: HintCollection) -> void:
	collection = p_collection


func add_hint(hint: Hint) -> void:
	pass


func get_filter() -> HintGroupFilter:
	return HintGroupFilter.new(_get_filter_helper(), add_hint)


func is_empty() -> bool:
	return hints.is_empty()


func is_full() -> bool:
	return true


func remove_hint(hint: Hint) -> void:
	pass


func clear() -> void:
	pass


func _get_filter_helper() -> Array[Hint]:
	return []
