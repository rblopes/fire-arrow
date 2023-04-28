extends Node

signal updated(current_item: Item)

var _cursor: int = 0
var items: Array[Item] = []


func _get_item() -> Item:
	return null if items.is_empty() else items[_cursor]


func decrease() -> void:
	_cursor = wrapi(_cursor - 1, 0, len(items))
	updated.emit(_get_item())


func increase() -> void:
	_cursor = wrapi(_cursor + 1, 0, len(items))
	updated.emit(_get_item())


func reset() -> void:
	_cursor = 0
	updated.emit(_get_item())
