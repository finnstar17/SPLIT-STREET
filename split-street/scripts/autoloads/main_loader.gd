extends Node

# all autoload variables

var current_song : String
var current_speed : float
var current_accuracy : int
var current_note_number = 0
var current_combo = 0
var current_bar = 0
var bar_detected = 0
var score = 0

var current_time = ""
var full_length = "0:00"
var time_in_sec = 0
var length_in_sec = 0

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