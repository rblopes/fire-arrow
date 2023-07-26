extends HBoxContainer

signal command_requested(command: String, metadata: Variant)

enum MenuId {
	NONE,
	PRESET,
	RESUME_STOPWATCH,
	RESET_STOPWATCH,
	RESET_TRACKER,
	TAKE_SCREENSHOT,
	OPEN_SCREENSHOT_FOLDER,
	OPEN_DATA_FOLDER,
	SETTINGS,
	QUIT,
}


func _ready() -> void:
	_setup_menu($Menu.get_popup())


func set_title(text: String) -> void:
	$Title.text = text


func _on_menu_index_pressed(index: int, menu: PopupMenu) -> void:
	match menu.get_item_id(index):
		MenuId.PRESET:
			var preset_name = menu.get_item_metadata(index)
			command_requested.emit("load_preset", {"preset_name": preset_name})
		MenuId.RESUME_STOPWATCH:
			command_requested.emit("resume_stopwatch")
		MenuId.RESET_STOPWATCH:
			command_requested.emit("reset_stopwatch")
		MenuId.RESET_TRACKER:
			command_requested.emit("reset_tracker")
		MenuId.TAKE_SCREENSHOT:
			command_requested.emit("take_screenshot")
		MenuId.OPEN_SCREENSHOT_FOLDER:
			command_requested.emit("open_screenshot_folder")
		MenuId.OPEN_DATA_FOLDER:
			command_requested.emit("open_data_folder")
		MenuId.SETTINGS:
			command_requested.emit("settings")
		MenuId.QUIT:
			command_requested.emit("quit")


func _setup_menu(menu: PopupMenu) -> void:
	menu.index_pressed.connect(_on_menu_index_pressed.bind(menu))
	#-----------------------------------------------------------------------------
	menu.add_child(_setup_presets_submenu())
	menu.add_submenu_item("Presets", "PresetsSubMenu")
	menu.add_separator()
	#-----------------------------------------------------------------------------
	@warning_ignore("int_as_enum_without_cast", "int_as_enum_without_match")
	menu.add_item("Pause/Resume Stopwatch", MenuId.RESUME_STOPWATCH, KEY_F4)
	@warning_ignore("int_as_enum_without_cast", "int_as_enum_without_match")
	menu.add_item("Reset Stopwatch", MenuId.RESET_STOPWATCH, KEY_MASK_CTRL | KEY_F4)
	@warning_ignore("int_as_enum_without_cast", "int_as_enum_without_match")
	menu.add_item("Reset Tracker", MenuId.RESET_TRACKER, KEY_MASK_CTRL | KEY_F2)
	menu.add_separator()
	#-----------------------------------------------------------------------------
	@warning_ignore("int_as_enum_without_cast", "int_as_enum_without_match")
	menu.add_item("Take Screenshot", MenuId.TAKE_SCREENSHOT, KEY_F12)
	menu.add_item("Open Screenshot Folder", MenuId.OPEN_SCREENSHOT_FOLDER)
	menu.add_item("Open Data Folder", MenuId.OPEN_DATA_FOLDER)
	@warning_ignore("int_as_enum_without_cast", "int_as_enum_without_match")
	menu.add_item("Settings...", MenuId.SETTINGS, KEY_MASK_CTRL | KEY_D)
	menu.add_separator()
	#-----------------------------------------------------------------------------
	@warning_ignore("int_as_enum_without_cast", "int_as_enum_without_match")
	menu.add_item("Quit", MenuId.QUIT, KEY_MASK_CTRL | KEY_Q)


func _setup_presets_submenu() -> PopupMenu:
	var node := PopupMenu.new()
	node.index_pressed.connect(_on_menu_index_pressed.bind(node))
	node.name = "PresetsSubMenu"
	node.add_separator("Built-in Options")
	var i := 1
	for info in TrackerLayoutLoader.get_builtin_presets_info():
		node.add_item(info.get("title"), MenuId.PRESET)
		node.set_item_metadata(i, info.get("preset_name"))
		i += 1
	return node
