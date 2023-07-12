extends MarginContainer

var _tracker_layout: TrackerLayout = null


func _init() -> void:
	TrackerLayoutLoader.loaded.connect(_on_tracker_layout_loaded)


func _ready() -> void:
	%Prizes.apply_settings()
	%Songs.apply_settings()
	TrackerLayoutLoader.load_builtin_layout(Settings.get_value("tracker", "preset"))


func _on_header_bar_command_requested(command: String, metadata: Variant = null) -> void:
	match command:
		"load_preset":
			var preset_name: String = metadata.get("preset_name")
			TrackerLayoutLoader.load_builtin_layout(preset_name)
			Settings.set_value("tracker", "preset", preset_name)
			Settings.save()
		"resume_stopwatch":
			%Stopwatch.resume()
		"reset_stopwatch":
			%Stopwatch.reset()
		"reset_tracker":
			%Items.reset()
			%Prizes.reset()
			%Songs.reset()
			%Hints.reset()
			%Stopwatch.reset()
		"take_screenshot":
			UiHelper.take_screenshot(get_window())
		"open_data_folder":
			OS.shell_open(OS.get_user_data_dir())
		"settings":
			pass
		"quit":
			Settings.save()
			get_tree().quit()


func _on_tracker_layout_loaded(tracker_layout: TrackerLayout) -> void:
	_tracker_layout = tracker_layout
	%HeaderBar.set_title(_tracker_layout.title)
	%Hints.clear_hint_groups()
	%Items.reset()
	%Prizes.reset()
	%Songs.reset()
	%Hints.add_hint_groups(_tracker_layout.groups)
	%Stopwatch.reset()
