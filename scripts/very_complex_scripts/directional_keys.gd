extends "res://scripts/very_complex_scripts/button_size.gd"

@onready var all_songs = self.get_parent().get_parent().get_node("AllSongs")
@export var direction : int

func _ready():
	animate()

	await get_tree().process_frame

	area.input_event.connect(func(_camera, event, _position, _normal, _shape_idx):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var current_pos = all_songs.get_meta("song_position")
			all_songs.set_meta("song_position", clamp(current_pos + direction, 0.0, all_songs.get_child_count() - 1))

			var new_pos = all_songs.get_meta("song_position")
			if new_pos != current_pos:
				var tween = all_songs.create_tween()
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_EXPO)
				tween.tween_property(all_songs, "position:x", new_pos * -1.25, 0.5)
	)
