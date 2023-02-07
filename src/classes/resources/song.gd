class_name Song
extends Resource

@export
var icon: Icon = null

var is_checked: bool:
	set(value):
		is_checked = value
		changed.emit()

var learned_from: Song:
	set(value):
		learned_from = value
		changed.emit()


func get_icon_texture() -> Texture2D:
	return icon.texture if is_instance_valid(icon) else null
