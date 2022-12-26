class_name Prize
extends Resource

const UNKNOWN_ASSIGNED_LABEL := "N/D"

export var icon: Resource
export var is_free: bool = false
var is_checked: bool setget set_checked
var assigned_label: String setget set_assigned_label, get_assigned_label


func get_icon_texture() -> Texture:
	return icon.texture


func get_label() -> String:
	return icon.label if icon is Icon else UNKNOWN_ASSIGNED_LABEL


func get_assigned_label() -> String:
	return UNKNOWN_ASSIGNED_LABEL if assigned_label.empty() else assigned_label


func set_checked(value: bool) -> void:
	is_checked = value
	emit_changed()


func set_assigned_label(value: String) -> void:
	assigned_label = value
	emit_changed()
