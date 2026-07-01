extends Node

# all autoload variables

var current_song : String
var current_accuracy : int
var current_note_number = 0
var current_combo = 0
var current_bar = 0

func set_number(type_object : String, type_set : String, number : int):
	match type_object:
		"bar":
			match type_set:
				"set":
					current_bar = number
				"add":
					current_bar += 1
		"accuracy":
			current_accuracy = number
		"note_number":
			current_note_number += 1
		"combo":
			match type_set:
				"set":
					current_combo = 0
				"add":
					current_combo += 1

# song loader
func set_current_song(path : String):
	current_song = path

# chart loader
func load_chart(path : String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var json_string = file.get_as_text()

		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			return json.data