extends Node3D

@export_range(0, 4) var line : int
@export_range(0, 2) var plane : int
@onready var hold_note_mesh = $HoldNoteMesh
var pos = 0
var is_hit = false
var is_collected = false
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
			if picker.general_collecting:
				is_collected = true

				hide()

func _on_area_3d_hold_exited(area: Area3D) -> void:
	if area.is_in_group("picker"):
		is_hit = true
		picker = area.get_parent()

func _on_area_3d_hold_entered(area: Area3D) -> void:
	if area.is_in_group("picker"):
		is_hit = false
		picker = null
