extends Node

@export
var prizes: Array[Prize] = []

@onready
var should_check_in_reverse: bool = PreferencesManager.get_value("prizes", "check_in_reverse")


func assign_label(source: Prize, destination: Prize) -> void:
	if should_check_in_reverse:
		do_assign_label(destination, source)
	else:
		do_assign_label(source, destination)


func do_assign_label(source: Prize, destination: Prize) -> void:
	source.assigned_label = destination.get_label()
	source.is_checked = source.is_checked or destination.is_free


func clear_medallions() -> void:
	clear_prizes(prizes.slice(0, 5))


func clear_stones() -> void:
	clear_prizes(prizes.slice(6, 8))


func clear_prizes(prizes_to_clear: Array[Prize]) -> void:
	for prize in prizes_to_clear:
		prize.is_checked = false
		prize.assigned_label = Prize.UNKNOWN_ASSIGNED_LABEL


func reset() -> void:
	clear_prizes(prizes)


func uncheck_all() -> void:
	for prize in prizes:
		if is_instance_valid(prize):
			prize.is_checked = false
