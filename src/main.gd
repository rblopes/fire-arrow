extends MarginContainer

const MODES: Dictionary = {
	"standard_s5": "res://assets/data/standard_s5.json",
	"standard_s6": "res://assets/data/standard_s6.json",
}


func _load_tracker_layout(mode: String) -> TrackerLayout:
	assert(mode in MODES)
	return TrackerLayoutLoader.load_layout(MODES.get(mode))


func _ready() -> void:
	var tracker_layout := _load_tracker_layout(PreferencesManager.get_value("preset", "mode"))
	Tracker.setup_hints(tracker_layout)
	%Hints.hint_groups = tracker_layout.groups


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if event.is_action_pressed("ui_resume_stopwatch"):
		Tracker.resume_stopwatch()
	if event.is_action_pressed("ui_reset_stopwatch"):
		Tracker.reset_stopwatch()
	if event.is_action_pressed("ui_reset_tracker"):
		Tracker.reset()
	if event.is_action_pressed("take_screenshot"):
		UiHelper.take_screenshot(self)
	if event.is_action_pressed("ui_open_data_dir"):
		OS.shell_open(OS.get_user_data_dir())
	if event.is_action_pressed("ui_quit"):
		PreferencesManager.save_preferences()
		get_tree().quit()
