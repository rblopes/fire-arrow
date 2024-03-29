extends MarginContainer

var _tracker_layout: TrackerLayout = null


func _init() -> void:
	TrackerLayoutLoader.loaded.connect(_on_tracker_layout_loaded)


func _ready() -> void:
	%Icons.apply_settings()
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
			%Icons.reset()
			%Hints.reset()
			%Stopwatch.reset()
		"take_screenshot":
			var outdir: String = Settings.get_value("screenshots", "outdir")
			if Settings.is_default_screenshot_outdir(outdir) and not DirAccess.dir_exists_absolute(outdir):
				if DirAccess.make_dir_absolute(outdir) != OK:
					return
			UiHelper.take_screenshot(outdir, get_window())
		"open_screenshot_folder":
			var outdir: String = Settings.get_value("screenshots", "outdir")
			if DirAccess.dir_exists_absolute(outdir):
				OS.shell_open(ProjectSettings.globalize_path(outdir))
		"open_data_folder":
			OS.shell_open(OS.get_user_data_dir())
		"settings":
			Settings.show_dialog()
		"quit":
			Settings.save()
			get_tree().quit()


func _on_tracker_layout_loaded(tracker_layout: TrackerLayout) -> void:
	_tracker_layout = tracker_layout
	%HeaderBar.set_title(_tracker_layout.title)
	%Hints.clear_hint_groups()
	%Icons.reset()
	%Hints.add_hint_groups(_tracker_layout.groups)
	%Stopwatch.reset()
