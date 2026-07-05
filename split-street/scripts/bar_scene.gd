extends Node3D

@export var detected = false
var note_scene = preload("res://scenes/hit_note_scene.tscn")
var hold_note_scene = preload("res://scenes/hold_note.tscn")
var current_bar = MainLoader.current_bar

var note_scale = 0.75

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
				note_instance.pos = note.pos * note_scale

				if "length" in note:
					for index_1 in range(0, note.length):
						for index_2 in range(0, 5):
							if index_1 == 0 and index_2 == 0:
								pass
							else:
								var hold_note_instance = hold_note_scene.instantiate()
								hold_note_instance.line = note.line
								hold_note_instance.plane = note.plane
								hold_note_instance.pos = ((note.pos * note_scale) + index_2 * 0.15 + (index_1 * note_scale))

								if (index_2 == 0 and index_1 > 0) or index_2 == 2:
									hold_note_instance.grant_point = true

								add_child(hold_note_instance)
				if "type" in note:
					note_instance.type = note.type

				add_child(note_instance)


# my bad i thought this scrolled the thing but i forgot because i didnt track that well
