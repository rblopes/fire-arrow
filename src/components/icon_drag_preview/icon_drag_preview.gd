extends Control


func set_icon(data) -> void:
	$icon.texture = data.get_icon_texture()
