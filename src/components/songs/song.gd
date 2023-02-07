extends Control

@export
var song: Song:
	set(value):
		song = value
		song.changed.connect(_on_song_changed)
		$Big.texture = song.icon.texture


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return is_instance_valid(data)


func _drop_data(at_position: Vector2, data: Variant) -> void:
	owner.assign_song(data, song)


func _get_drag_data(at_position: Vector2) -> Variant:
	return UiHelper.set_icon_drag_preview_for(self, song)


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_mouse_left_button"):
		owner.toggle_song(song)
	if event.is_action_released("ui_mouse_right_button"):
		owner.unassign_song(song)


func _on_song_changed() -> void:
	$Big.material.set_shader_parameter("disabled", song.is_checked)
	$Small.texture = song.learned_from.icon.texture if song.learned_from is Song else null
