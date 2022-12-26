extends Node

export (Array, Resource) var items: Array


func reset() -> void:
	for item in items:
		if is_instance_valid(item):
			item.uncheck()
