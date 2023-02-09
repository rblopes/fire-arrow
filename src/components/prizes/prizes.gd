extends PanelContainer

enum {
	NONE,
	UNCHECK_ALL,
	CLEAN_MEDALLIONS,
	CLEAN_STONES,
	CLEAN_ALL,
}


func _on_context_menu_id_pressed(id: int) -> void:
	match id:
		UNCHECK_ALL:
			get_tree().call_group("prizes", "uncheck")
		CLEAN_MEDALLIONS:
			get_tree().call_group("prizes", "clear_label_if", Prize.Type.MEDALLION)
		CLEAN_STONES:
			get_tree().call_group("prizes", "clear_label_if", Prize.Type.JEWEL)
		CLEAN_ALL:
			reset()


func _on_context_menu_requested(at_position: Vector2) -> void:
	$ContextMenu.popup(Rect2i(at_position, $ContextMenu.size))


func reset() -> void:
	get_tree().call_group("prizes", "reset")


func set_drag_and_drop_behaviour(should_check_in_reverse: bool) -> void:
	get_tree().set_group("prizes", "should_check_in_reverse", should_check_in_reverse)
