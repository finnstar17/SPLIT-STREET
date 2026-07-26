extends "res://scripts/very_complex_scripts/button_size.gd"

func _ready():
	animate()

	area.input_event.connect(func(_camera, event, _position, _normal, _shape_idx):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_parent().get_parent().start()
	)
