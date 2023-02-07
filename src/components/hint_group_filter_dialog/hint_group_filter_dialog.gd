extends Popup

var _hint_group_filter: HintGroupFilter


func _on_about_to_popup() -> void:
	$FilteredHintList.update_list(_hint_group_filter.filter())


func _on_filtered_hint_list_filter_updated(value: String) -> void:
	if is_instance_valid(_hint_group_filter):
		$FilteredHintList.update_list(_hint_group_filter.filter(value))


func _on_filtered_hint_list_item_selected(hint: Hint) -> void:
	_hint_group_filter.select(hint)
	hide()


func _on_popup_hide() -> void:
	_hint_group_filter = null
	$FilteredHintList.clear()


func prompt(hint_group_filter: HintGroupFilter, control: Control) -> void:
	_hint_group_filter = hint_group_filter
	popup(Rect2i(
		control.get_global_rect().position - Vector2(0, 128),
		Vector2(control.size.x, 128)
	))
