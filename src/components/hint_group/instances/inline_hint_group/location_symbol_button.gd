extends Button

signal removal_requested(hint)

var hint: LocationHint = null:
	set(value):
		if is_instance_valid(value):
			hint = value


func _ready() -> void:
	if is_instance_valid(hint):
		text = hint.symbol


func _pressed() -> void:
	reset()


func reset() -> void:
	removal_requested.emit(hint)
	queue_free()
