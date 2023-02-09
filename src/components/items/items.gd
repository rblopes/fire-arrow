extends PanelContainer


func reset() -> void:
	get_tree().call_group("items", "reset")
