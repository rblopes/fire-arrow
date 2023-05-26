extends PanelContainer

signal hint_filter_requested(hint_group_filter: HintGroupFilter, host_control: Control)

var hint_group: HintGroup:
	set(value):
		if is_instance_valid(value):
			hint_group = value
			hint_group.hint_added.connect(_on_hint_added)
			hint_group.hint_removed.connect(_on_hint_removed)

@onready
var _hint_button_scenes: Dictionary = get_meta("hint_button_scenes")


func _ready() -> void:
	theme = theme.duplicate()
	if is_instance_valid(hint_group):
		theme.set_goal_location_hint_button_description_label_font_color(hint_group.color)
		theme.set_hint_group_heading_button_font_colors(hint_group.color)
		%HeaderButton.text = hint_group.name.to_upper()
		%HeaderButton.shortcut = hint_group.shortcut
		_fill_pinned_hints()


func _add_hint_button(hint: Hint) -> void:
	var node := _instantiate_hint_button(hint)
	node.hint = hint
	%Hints.add_child(node)


func _fill_pinned_hints() -> void:
	if hint_group is MiscellaneousHintGroup:
		for hint in hint_group.collection.filter(func(x): return x.is_pinned()):
			hint_group.add_hint(hint)


func _get_hint_button_scene(hint: Hint) -> PackedScene:
	return _hint_button_scenes.get(hint.get_script())


func _instantiate_hint_button(hint: Hint) -> Button:
	var packed_scene: PackedScene = _get_hint_button_scene(hint)
	assert(is_instance_valid(packed_scene), "Missing scene for '%s' hint." % [hint])
	return packed_scene.instantiate()


func _on_header_button_pressed() -> void:
	if not hint_group.is_full():
		hint_filter_requested.emit(hint_group.get_filter(), self)


func _on_hint_added(hint: Hint) -> void:
	if is_instance_valid(hint):
		_add_hint_button(hint)
		_set_placeholder_visibility(false)


func _on_hint_button_removal_requested(hint: Hint) -> void:
	if is_instance_valid(hint):
		if not (hint is MiscellaneousHint and hint.is_pinned()):
			hint_group.remove_hint(hint)


func _on_hint_removed(_hint: Hint) -> void:
	_set_placeholder_visibility(hint_group.is_empty())


func _on_hints_child_entered_tree(button: Button) -> void:
	button.owner = self
	button.removal_requested.connect(_on_hint_button_removal_requested)
	if button.hint is SpecialLocationHint:
		button.pressed.connect(func(): hint_filter_requested.emit(button.get_filter(), button))


func _set_placeholder_visibility(value: bool) -> void:
	%Placeholder.visible = value
