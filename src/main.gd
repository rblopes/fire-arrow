extends MarginContainer

const MODES: Dictionary = {
	"league_s4": "res://assets/data/league_s4.json",
	"standard_s5": "res://assets/data/standard_s5.json",
	"standard_s6": "res://assets/data/standard_s6.json",
}

var tracker_layout: TrackerLayout = null


func _load_tracker_layout(mode: String) -> TrackerLayout:
	assert(mode in MODES)
	return TrackerLayoutLoader.load_layout(MODES.get(mode))


func _ready() -> void:
	tracker_layout = _load_tracker_layout(PreferencesManager.get_value("preset", "mode"))
	%Prizes.set_drag_and_drop_behaviour(PreferencesManager.get_value("prizes", "check_in_reverse"))
	%Songs.set_check_behaviour(PreferencesManager.get_value("songs", "autocheck"))
	%Songs.set_drag_and_drop_behaviour(PreferencesManager.get_value("songs", "check_in_reverse"))
	%Hints.set_hint_groups(tracker_layout.groups)


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
		UiHelper.take_screenshot(self)
	if event.is_action_pressed("ui_open_data_dir"):
		OS.shell_open(OS.get_user_data_dir())
	if event.is_action_pressed("ui_quit"):
		PreferencesManager.save_preferences()
		get_tree().quit()
