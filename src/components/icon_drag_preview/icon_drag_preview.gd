extends Control


func set_icon(data: Variant) -> void:
	$Icon.texture = data.get_icon_texture()
