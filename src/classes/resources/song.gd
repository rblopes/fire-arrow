class_name Song
extends Resource

@export
var texture: Texture2D = null

var is_checked: bool:
	set(value):
		is_checked = value
		changed.emit()

var learned_from: Song:
	set(value):
		learned_from = value
		changed.emit()
