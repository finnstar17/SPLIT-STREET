extends Node3D

@export_range(0, 4) var line : int
@export_range(0, 2) var plane : int
var pos = 0
var is_hit = false
var is_collected = false
var level = 0
var picker : Node3D

func _ready():
	_set_position()
	
func _process(_delta: float) -> void:
	collect()

	if not is_collected:
		if global_position.z < -4.6:
			hide()
		else:
			show()
		if global_position.z > 0:
			MainLoader.set_number("combo", "set", 0)

func _set_position():
	var x_pos : float
	var y_pos : float

	# setting x position first in-game
	match line:
		1:
			x_pos = -0.6
		2:
			x_pos = -0.2
		3:
			x_pos = 0.2
		4:
			x_pos = 0.6
	# setting y position for either plane
	match plane:
		1:
			y_pos = -0.6
		2:
			y_pos = 0.6

	position = Vector3(x_pos, y_pos, -pos)

func collect():
	if not is_collected:
		if is_hit and picker:
			if picker.is_collecting:
				is_collected = true
				picker.is_collecting = false

				var distance = abs(global_position.z + 0.8)

				if distance > 0.16:
					MainLoader.set_number("combo", "set", 0)
				else:
					MainLoader.set_number("combo", "add", 0)
					
				if distance <= 0.16:
					level = 1
				if distance <= 0.12:
					level = 2
				if distance <= 0.08:
					level = 3

				MainLoader.set_number("accuracy", "", level)
				MainLoader.set_number("note_number", "add", 0)

				hide()

func _on_area_3d_entered(area: Area3D) -> void:
	if area.is_in_group("picker"):
		is_hit = true
		picker = area.get_parent()

func _on_area_3d_exited(area: Area3D) -> void:
	if area.is_in_group("picker"):
		is_hit = false
		picker = null
