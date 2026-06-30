extends Node

# all autoload variables

var current_song : String
var current_accuracy : int
var current_note_number = 0

# bar manager
var current_bar = 0

func add_bar():
	current_bar += 1
	# print(str(current_bar))

func set_bar(number : int):
	current_bar = number

# accuracy manager
func set_accuracy(new_accuracy : int):
	current_accuracy = new_accuracy

func add_note_number():
	current_note_number += 1

func set_note_number(new_number : int):
	current_note_number = new_number

# song manager
func set_current_song(song : String):
	current_song = song

# chart loader
func load_chart(path : String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var json_string = file.get_as_text()

		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			return json.data