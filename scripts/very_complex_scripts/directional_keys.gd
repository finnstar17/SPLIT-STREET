extends "res://scripts/very_complex_scripts/button_size.gd"

@onready var all_songs = self.get_parent().get_parent().get_node("AllSongs")

func _ready():
	animate()

	area.input_event.connect(func(_camera, event, _position, _normal, _shape_idx):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			all_songs.position.x += 1.25
	)
