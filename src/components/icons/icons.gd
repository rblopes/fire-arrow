extends GridContainer


func _init() -> void:
	Settings.updated.connect(apply_settings)


func apply_settings() -> void:
	get_tree().set_group("prizes", "should_check_in_reverse", Settings.get_value("prizes", "check_in_reverse"))
	get_tree().set_group("songs", "should_autocheck_learned_song", Settings.get_value("songs", "autocheck"))
	get_tree().set_group("songs", "should_check_in_reverse", Settings.get_value("songs", "check_in_reverse"))


func reset() -> void:
	get_tree().call_group("icons", "reset")
