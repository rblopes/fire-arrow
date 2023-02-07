class_name Prize
extends Resource

const UNKNOWN_ASSIGNED_LABEL := "N/D"

@export
var icon: Icon = null

@export
var is_free: bool = false

var is_checked: bool:
	set(value):
		is_checked = value
		changed.emit()

var assigned_label: String = UNKNOWN_ASSIGNED_LABEL:
	get:
		return UNKNOWN_ASSIGNED_LABEL if assigned_label.is_empty() else assigned_label
	set(value):
		assigned_label = value
		changed.emit()


func get_icon_texture() -> Texture2D:
	return icon.texture if is_instance_valid(icon) else null


func get_label() -> String:
	return icon.label if is_instance_valid(icon) else UNKNOWN_ASSIGNED_LABEL
