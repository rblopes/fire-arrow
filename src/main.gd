extends MarginContainer

var tracker_layout: TrackerLayout = null


func _ready() -> void:
	tracker_layout = TrackerLayoutLoader.load_builtin_layout(Settings.get_value("tracker", "preset"))
	%Prizes.apply_settings()
	%Songs.apply_settings()
	%Hints.add_hint_groups(tracker_layout.groups)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if event.is_action_pressed("ui_resume_stopwatch"):
		%Stopwatch.resume()
	if event.is_action_pressed("ui_reset_stopwatch"):
		%Stopwatch.reset()
	if event.is_action_pressed("ui_reset_tracker"):
		%Items.reset()
		%Prizes.reset()
		%Songs.reset()
		%Hints.reset()
		%Stopwatch.reset()
	if event.is_action_pressed("take_screenshot"):
		UiHelper.take_screenshot(get_window())
	if event.is_action_pressed("ui_open_data_dir"):
		OS.shell_open(OS.get_user_data_dir())
	if event.is_action_pressed("ui_quit"):
		Settings.save()
		get_tree().quit()
