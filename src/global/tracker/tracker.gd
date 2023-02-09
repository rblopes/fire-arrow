extends Node

var tracker_layout: TrackerLayout


func get_collection(collection_name: String) -> Node:
	return get_node_or_null(collection_name)


func get_stopwatch() -> Stopwatch:
	return $Stopwatch as Stopwatch


func reset() -> void:
	$Groups.reset()
	$Stopwatch.reset()


func reset_stopwatch() -> void:
	$Stopwatch.reset()


func resume_stopwatch() -> void:
	match $Stopwatch.current_state:
		Stopwatch.States.STOPPED:
			$Stopwatch.start()
		Stopwatch.States.RUNNING:
			$Stopwatch.pause()
		Stopwatch.States.PAUSED:
			$Stopwatch.resume()


func setup_hints(p_tracker_layout: TrackerLayout) -> void:
	tracker_layout = p_tracker_layout
	$Groups.hint_groups = tracker_layout.groups
	$Groups.init_hint_groups()
