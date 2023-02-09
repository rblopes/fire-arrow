extends PanelContainer


func reset() -> void:
	get_tree().call_group("songs", "reset")


func set_check_behaviour(should_autocheck_learned_songs: bool) -> void:
	get_tree().set_group("songs", "should_autocheck_learned_song", should_autocheck_learned_songs)


func set_drag_and_drop_behaviour(should_check_in_reverse: bool) -> void:
	get_tree().set_group("songs", "should_check_in_reverse", should_check_in_reverse)
