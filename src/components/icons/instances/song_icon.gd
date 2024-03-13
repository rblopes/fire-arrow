extends "../icon.gd"

var should_autocheck_learned_song: bool = false
var should_check_in_reverse: bool = false

@export
var song: Song = null:
	set(value):
		if is_instance_valid(value):
			song = value
			song.changed.connect(_on_song_changed)
			$Icon.texture = song.texture


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return is_instance_valid(data) and data is Song


func _drop_data(at_position: Vector2, dropped_song: Variant) -> void:
	song.learned_from = dropped_song
	if should_autocheck_learned_song:
		if should_check_in_reverse:
			song.is_checked = true
		else:
			dropped_song.is_checked = true


func _get_drag_data(at_position: Vector2) -> Variant:
	UiHelper.set_drag_preview_for(self, song)
	return song


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_mouse_left_button"):
		song.is_checked = not song.is_checked
		if should_autocheck_learned_song:
			if song.is_checked and song.learned_from == null:
				song.learned_from = song
	if event.is_action_released("ui_mouse_right_button"):
		song.learned_from = null


func _on_song_changed() -> void:
	$Icon.material.set_shader_parameter("disabled", song.is_checked)
	$SmallIcon.texture = song.learned_from.texture if song.learned_from is Song else null


func reset() -> void:
	song.is_checked = false
	song.learned_from = null
