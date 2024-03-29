extends MarginContainer

const COLOR_RUNNING = Color.GREEN_YELLOW
const COLOR_PAUSED = Color.GRAY
const COLOR_STOPPED = Color.WHITE
const HOUR_FORMAT: String = "%d:%02d:%02d"
const MINUTE_FORMAT: String = "%d:%02d"
const SUBSECOND_FORMAT: String = "%02d"

@onready
var _model: Stopwatch = $Model

@onready
var _hour_label: Label = $Contents/Hour

@onready
var _subsecond_label: Label = $Contents/Subsecond


func _change_label_colors(color: Color = COLOR_STOPPED) -> void:
	_hour_label.add_theme_color_override("font_color", color)
	_subsecond_label.add_theme_color_override("font_color", color)


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
	return SUBSECOND_FORMAT % [int(fmod(time, 1) * 100)]


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_left_button"):
		resume()
	if event.is_action_pressed("ui_mouse_right_button"):
		reset()


func _on_stopwatch_state_changed(state: int) -> void:
	match state:
		Stopwatch.States.STOPPED:
			_change_label_colors(COLOR_STOPPED)
		Stopwatch.States.RUNNING:
			_change_label_colors(COLOR_RUNNING)
		Stopwatch.States.PAUSED:
			_change_label_colors(COLOR_PAUSED)
	_update_text(_model.elapsed_time)


func _update_text(time: float) -> void:
	_hour_label.text = _format_hour(time)
	_subsecond_label.text = _format_subsecond(time)


func reset() -> void:
	_model.reset()


func resume() -> void:
	match _model.current_state:
		Stopwatch.States.STOPPED:
			_model.start()
		Stopwatch.States.RUNNING:
			_model.pause()
		Stopwatch.States.PAUSED:
			_model.resume()
