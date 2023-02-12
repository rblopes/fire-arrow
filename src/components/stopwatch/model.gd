class_name Stopwatch
extends Node

signal state_changed(state: States)
signal updated(elapsed_time: float)

enum States {
	STOPPED,
	RUNNING,
	PAUSED,
}

var current_state: int = States.STOPPED
var elapsed_time: float = 0.0


func _change_state(state: int) -> void:
	current_state = state
	emit_signal("state_changed", current_state)


func _process(delta: float) -> void:
	if current_state == States.RUNNING:
		elapsed_time += delta
		emit_signal("updated", elapsed_time)


func pause() -> void:
	_change_state(States.PAUSED)


func reset() -> void:
	elapsed_time = 0.0
	_change_state(States.STOPPED)


func resume() -> void:
	_change_state(States.RUNNING)


func start() -> void:
	_change_state(States.RUNNING)
