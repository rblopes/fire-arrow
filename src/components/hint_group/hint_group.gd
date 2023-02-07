extends PanelContainer

@onready
var hint_buttons: Dictionary = get_meta("hint_button_scenes")

var hint_group: HintGroup:
	set = set_hint_group


func _add_hint_button_for(hint: Hint) -> void:
	if is_instance_valid(hint):
		var button: Button = _create_hint_button_for(hint)
		%Hints.add_child(button)
		button.owner = owner
		button.removal_requested.connect(_on_hint_button_removal_requested)


func _create_hint_button_for(hint: Hint) -> Button:
	var packed_scene: PackedScene = _get_hint_button_packed_scene_for_hint(hint)
	assert(is_instance_valid(packed_scene))
	var result: Button = packed_scene.instantiate()
	result.hint = hint
	return result


func _fill_pinned_hints() -> void:
	for hint in hint_group.hints:
		_add_hint_button_for(hint)
	_toggle_placeholder()


func _get_hint_button_packed_scene_for_hint(hint: Hint) -> PackedScene:
	return hint_buttons.get(hint.get_script())


func _on_hint_added(hint: Hint) -> void:
	_add_hint_button_for(hint)
	_toggle_placeholder()


func _on_hint_button_removal_requested(hint: Hint) -> void:
	if not hint.is_pinned():
		hint_group.remove_hint(hint)


func _on_hint_removed(_hint: Hint) -> void:
	_toggle_placeholder()


func _on_reset() -> void:
	get_tree().call_group("hints", "queue_free_on_reset")
	_toggle_placeholder()


func _toggle_placeholder() -> void:
	%Placeholder.visible = hint_group.is_empty()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if hint_group.is_full():
		return
	if hint_group.shortcut is Shortcut:
		if event.is_pressed() and hint_group.shortcut.matches_event(event):
			owner.request_hint_group_filter_dialog(hint_group.get_filter(), self)


func set_hint_group(value: HintGroup) -> void:
	if is_instance_valid(value):
		hint_group = value
		%Heading.text = hint_group.name
		add_theme_stylebox_override("panel", get_theme_stylebox("panel").duplicate())
		get_theme_stylebox("panel").bg_color = hint_group.bg_color
		hint_group.reset.connect(_on_reset)
		hint_group.hint_added.connect(_on_hint_added)
		hint_group.hint_removed.connect(_on_hint_removed)
		_fill_pinned_hints()
