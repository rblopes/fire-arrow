extends VBoxContainer

signal filter_updated(value)
signal item_selected(item)

enum { UP = -1, DOWN = 1 }


func _commit_selection() -> void:
	if $delay.is_stopped():
		var item := _get_selected_item()
		if is_instance_valid(item):
			emit_signal("item_selected", item)


func _get_selected_item() -> Reference:
	var index := _get_selected_item_index()
	return $list.get_item_metadata(index) if index >= 0 else null


func _get_selected_item_index() -> int:
	return $list.get_selected_items()[0] if $list.is_anything_selected() else -1


func _move_filter_list_selection(up_or_down: int) -> void:
	if $delay.is_stopped():
		var item_count: int = $list.get_item_count()
		if item_count > 0:
			$list.select(wrapi(_get_selected_item_index() + up_or_down, 0, item_count))
			$list.ensure_current_is_visible()


func _on_delay_timeout() -> void:
	emit_signal("filter_updated", $filter.text.strip_edges())


func _on_filter_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		_move_filter_list_selection(UP)
	if event.is_action_pressed("ui_down"):
		_move_filter_list_selection(DOWN)


func _on_filter_text_changed(value: String) -> void:
	$delay.start()


func _on_filter_text_entered(value: String) -> void:
	_commit_selection()


func _on_list_item_activated(index: int) -> void:
	_commit_selection()


func clear() -> void:
	$filter.clear()
	$list.clear()


func grab_focus() -> void:
	$filter.grab_focus()


func update_list(hints: Array) -> void:
	$list.clear()
	if len(hints) > 0:
		for i in len(hints):
			$list.add_item(str(hints[i]))
			$list.set_item_metadata(i, hints[i])
		$list.select(0)
		$list.ensure_current_is_visible()
