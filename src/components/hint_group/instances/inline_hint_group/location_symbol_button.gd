extends Button

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
	queue_free()
