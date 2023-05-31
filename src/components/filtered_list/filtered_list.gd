extends VBoxContainer

signal filter_updated(value: String)
signal item_selected(item: Variant)

enum { UP = -1, DOWN = 1 }


func _get_selected_item() -> Variant:
	var index := _get_selected_item_index()
	return $List.get_item_metadata(index) if index >= 0 else null


func _get_selected_item_index() -> int:
	return $List.get_selected_items()[0] if $List.is_anything_selected() else -1


func _move_filter_list_selection(up_or_down: int) -> void:
	if $Delay.is_stopped():
		if $List.item_count > 0:
			$List.select(wrapi(_get_selected_item_index() + up_or_down, 0, $List.item_count))
			$List.ensure_current_is_visible()


func _on_delay_timeout() -> void:
	filter_updated.emit($Filter.text.strip_edges())


func _on_filter_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		_move_filter_list_selection(UP)
	if event.is_action_pressed("ui_down"):
		_move_filter_list_selection(DOWN)


func _on_filter_text_changed(value: String) -> void:
	$Delay.start()


func _on_visibility_changed() -> void:
	if is_visible_in_tree():
		$Filter.grab_focus()


func _submit_selection() -> void:
	if $Delay.is_stopped():
		item_selected.emit(_get_selected_item())


func clear() -> void:
	$Filter.clear()
	$List.clear()


func update_list(items: Array[Variant]) -> void:
	$List.clear()
	for item in items:
		var i: int = $List.add_item(str(item))
		$List.set_item_metadata(i, item)
		$List.set_item_tooltip(i, " ")
	if $List.item_count > 0:
		$List.select(0)
		$List.ensure_current_is_visible.call_deferred()
