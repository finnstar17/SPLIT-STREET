extends Node3D

var note_scene = preload("res://scenes/hit_note_scene.tscn")
var current_bar = MainLoader.current_bar

var note_scale = 0.5

func _ready():
	var current_song = MainLoader.current_song
	var chart_data = MainLoader.load_chart(current_song)
	add_notes(chart_data)

func add_notes(chart_data):
	if chart_data and current_bar > 0:
		var note_data = chart_data["note_data"]
		if current_bar <= note_data.size():
			var bar = note_data[str(current_bar)]
			var notes = bar["notes"]
			for note in notes:
				var note_instance = note_scene.instantiate()
				note_instance.line = note.line
				note_instance.plane = note.plane
				note_instance.pos = float(note.pos) * note_scale
				add_child(note_instance)

# my bad i thought this scrolled the thing but i forgot because i didnt track that well
