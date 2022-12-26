class_name Song
extends Resource

export var icon: Resource
var is_checked: bool setget set_checked
var learned_from: Resource setget set_learned_from


func get_icon_texture() -> Texture:
	return icon.texture


func set_checked(value: bool) -> void:
	is_checked = value
	emit_changed()


func set_learned_from(value: Song) -> void:
	learned_from = value
	emit_changed()
