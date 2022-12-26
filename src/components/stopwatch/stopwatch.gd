extends MarginContainer

const COLOR_RUNNING = Color.greenyellow
const COLOR_PAUSED = Color.gray
const COLOR_STOPPED = Color.white
const HOUR_FORMAT: String = "%d:%02d:%02d"
const MINUTE_FORMAT: String = "%d:%02d"
const MILLISECOND_FORMAT: String = "%02d"

onready var _model: Stopwatch = Tracker.get_stopwatch()
onready var _hour_label: Label = $contents/hour
onready var _subsecond_label: Label = $contents/subsecond


func _change_label_colors(color: Color = COLOR_STOPPED) -> void:
	_hour_label.add_color_override("font_color", color)
	_subsecond_label.add_color_override("font_color", color)


func _format_hour(time: float) -> String:
	var h := int(time / 3600.0)
	var m := int(time / 60.0) % 60
	var s := int(time) % 60
	if h > 0:
		return HOUR_FORMAT % [h, m, s]
	if m > 0:
		return MINUTE_FORMAT % [m, s]
	return str(s)


func _format_subsecond(time: float) -> String:
	return MILLISECOND_FORMAT % [int(fmod(time, 1) * 100)]


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_left_button"):
		Tracker.resume_stopwatch()
	if event.is_action_pressed("ui_mouse_right_button"):
		Tracker.reset_stopwatch()


func _on_stopwatch_state_changed(state: int) -> void:
	match state:
		Stopwatch.States.STOPPED:
			_change_label_colors(COLOR_STOPPED)
		Stopwatch.States.RUNNING:
			_change_label_colors(COLOR_RUNNING)
		Stopwatch.States.PAUSED:
			_change_label_colors(COLOR_PAUSED)
	_update_text(_model.elapsed_time)


func _ready() -> void:
	_model.connect("state_changed", self, "_on_stopwatch_state_changed")
	_model.connect("updated", self, "_update_text")


func _update_text(time: float) -> void:
	_hour_label.text = _format_hour(time)
	_subsecond_label.text = _format_subsecond(time)
