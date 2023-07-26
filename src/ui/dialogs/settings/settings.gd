extends Window

signal setting_changed(section: String, key: String, value: Variant)


func _ready() -> void:
	%AllowDragAndDropSongs.toggled.connect(_on_checkbox_toggled.bind("songs", "drag_and_drop"))
	%AutocheckSongs.toggled.connect(_on_checkbox_toggled.bind("songs", "autocheck"))
	%CheckSongsInReverse.toggled.connect(_on_checkbox_toggled.bind("songs", "check_in_reverse"))
	%AllowDragAndDropPrizes.toggled.connect(_on_checkbox_toggled.bind("prizes", "drag_and_drop"))
	%CheckPrizesInReverse.toggled.connect(_on_checkbox_toggled.bind("prizes", "check_in_reverse"))
	%EnableStopwatch.toggled.connect(_on_checkbox_toggled.bind("stopwatch", "enabled"))


func reset_fields(data: Dictionary) -> void:
	%AllowDragAndDropSongs.set_pressed_no_signal(data.get("songs_drag_and_drop", false))
	%AutocheckSongs.set_pressed_no_signal(data.get("songs_autocheck", false))
	%CheckSongsInReverse.set_pressed_no_signal(data.get("songs_check_in_reverse", false))
	%AllowDragAndDropPrizes.set_pressed_no_signal(data.get("prizes_drag_and_drop", false))
	%CheckPrizesInReverse.set_pressed_no_signal(data.get("prizes_check_in_reverse", false))
	%EnableStopwatch.set_pressed_no_signal(data.get("stopwatch_enabled", false))
	var screenshots_outdir: String = ProjectSettings.globalize_path(data.get("screenshots_outdir"))
	%OutDir.text = screenshots_outdir
	$FolderDialog.set_current_dir(screenshots_outdir)


func _on_checkbox_toggled(value: bool, section: String, key: String) -> void:
	setting_changed.emit(section, key, value)


func _on_choose_folder_pressed() -> void:
	$FolderDialog.popup_centered()


func _on_folder_dialog_dir_selected(dir: String) -> void:
	%OutDir.text = dir
	setting_changed.emit("screenshots", "outdir", dir)
