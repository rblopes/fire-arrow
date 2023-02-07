extends Node

@export
var songs: Array[Song] = []

@onready
var autocheck: bool = PreferencesManager.get_value("songs", "autocheck")

@onready
var inverted_song_check: bool = PreferencesManager.get_value("songs", "check_in_reverse")


func assign(song_from: Song, song_to: Song) -> void:
	song_to.learned_from = song_from
	if autocheck:
		if inverted_song_check:
			song_to.is_checked = true
		else:
			song_from.is_checked = true


func reset() -> void:
	for song in songs:
		if is_instance_valid(song):
			song.is_checked = false
			song.learned_from = null


func toggle(song: Song) -> void:
	song.is_checked = not song.is_checked
	if autocheck:
		if song.is_checked and song.learned_from == null:
			song.learned_from = song


func unassign(song: Song) -> void:
	song.learned_from = null
