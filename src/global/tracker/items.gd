extends Node

@export
var items: Array[Item] = []


func reset() -> void:
	for item in items:
		if is_instance_valid(item):
			item.uncheck()
