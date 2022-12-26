extends PanelContainer

onready var songs_manager: Node = Tracker.get_songs_manager()


func assign_song(source: Song, destination: Song) -> void:
	songs_manager.assign(source, destination)


func toggle_song(song: Song) -> void:
	songs_manager.toggle(song)


func unassign_song(song: Song) -> void:
	songs_manager.unassign(song)
