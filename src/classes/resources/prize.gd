class_name Prize
extends Resource

enum Type {
	NONE,
	JEWEL,
	MEDALLION,
}

const UNDEFINED_LABEL := "N/D"

@export
var label: String = ""

@export
var is_free: bool = false

@export
var texture: Texture2D = null

@export
var type: Type = Type.NONE

var is_checked: bool:
	set(value):
		is_checked = value
		changed.emit()

var assigned_label: String = UNDEFINED_LABEL:
	set(value):
		assigned_label = value
		changed.emit()
