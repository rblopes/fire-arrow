extends "../hint.gd"


func _ready() -> void:
	super()
	if is_instance_valid(hint):
		text = hint.symbol


func queue_free_on_reset() -> void:
	queue_free()
