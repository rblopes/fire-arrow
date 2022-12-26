extends Control

export var song: Resource setget set_song


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_mouse_left_button"):
		owner.toggle_song(song)
	if event.is_action_released("ui_mouse_right_button"):
		owner.unassign_song(song)


func can_drop_data(position: Vector2, data: Song) -> bool:
	return is_instance_valid(data)


func drop_data(position: Vector2, data: Song) -> void:
	owner.assign_song(data, song)


func get_drag_data(position: Vector2):
	return UiHelper.set_icon_drag_preview_for(self, song)


func refresh() -> void:
	$big.material.set_shader_param("disabled", song.is_checked)
	$tiny.texture = song.learned_from.icon.texture if song.learned_from is Song else null


func set_song(value: Song) -> void:
	song = value
	song.connect("changed", self, "refresh")
	$big.texture = song.icon.texture
	refresh()
