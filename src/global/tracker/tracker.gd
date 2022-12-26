extends Node

var tracker_layout: TrackerLayout


func get_collection(collection_name: String) -> Node:
	return get_node_or_null(collection_name.to_lower())


func get_prizes_manager() -> Node:
	return $prizes


func get_songs_manager() -> Node:
	return $songs


func get_stopwatch() -> Stopwatch:
	return $stopwatch as Stopwatch


func reset() -> void:
	$groups.reset()
	$items.reset()
	$prizes.reset()
	$songs.reset()
	$stopwatch.reset()


func reset_stopwatch() -> void:
	$stopwatch.reset()


func resume_stopwatch() -> void:
	match $stopwatch.current_state:
		Stopwatch.States.STOPPED:
			$stopwatch.start()
		Stopwatch.States.RUNNING:
			$stopwatch.pause()
		Stopwatch.States.PAUSED:
			$stopwatch.resume()


func setup_hints(p_tracker_layout: TrackerLayout) -> void:
	tracker_layout = p_tracker_layout
	$groups.hint_groups = tracker_layout.groups
	$groups.init_hint_groups()
