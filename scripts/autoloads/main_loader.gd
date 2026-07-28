extends Node

# all autoload variables

var song_path = ""
var current_song = ""
var current_speed = 0.0
var quarter_note = 0.0
var current_accuracy = 0
var current_note_number = 0
var current_combo = 0
var current_bar = 0
var bar_detected = 0
var score = 0

var current_time = ""
var full_length = "0:00"
var time_in_sec = 0
var length_in_sec = 0

var perfects = 0
var greats = 0
var goods = 0
var oks = 0
var misseds = 0

var game_mode = "menu"

var delta = 0.0
var started = false
var congrats = false

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

func reset(): # because im highkey
	current_song = ""
	current_speed = 0.0
	quarter_note = 0.0
	current_accuracy = 0
	current_note_number = 0
	current_combo = 0
	current_bar = 0
	bar_detected = 0
	score = 0

	current_time = ""
	full_length = "0:00"
	time_in_sec = 0
	length_in_sec = 0

	perfects = 0
	greats = 0
	goods = 0
	oks = 0
	misseds = 0

	delta = 0.0
	started = false
	congrats = false