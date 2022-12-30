extends PanelContainer

enum {
	NONE,
	UNCHECK_ALL,
	CLEAN_MEDALLIONS,
	CLEAN_STONES,
	CLEAN_ALL,
}

onready var prizes_manager: Node = Tracker.get_prizes_manager()


func _on_context_menu_id_pressed(id: int) -> void:
	match id:
		UNCHECK_ALL:
			prizes_manager.uncheck_all()
		CLEAN_MEDALLIONS:
			prizes_manager.clear_medallions()
		CLEAN_STONES:
			prizes_manager.clear_stones()
		CLEAN_ALL:
			prizes_manager.reset()


func _on_prizes_manager_reset() -> void:
	for node in $contents/icons.get_children():
		node.goal.reset()


func assign_symbol(source: Prize, destination: Prize) -> void:
	prizes_manager.assign_label(source, destination)


func request_context_menu(at_position: Vector2) -> void:
	$context_menu.popup(Rect2(at_position, $context_menu.rect_size))
