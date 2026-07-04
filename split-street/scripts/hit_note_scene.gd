extends Node3D

@export_range(0, 4) var line : int
@export_range(0, 2) var plane : int
@export var type : int = 1
@onready var note_mesh = $NoteMesh
var pos = 0
var is_hit = false
var is_collected = false
var missed = false
var level = 0
var picker : Node3D

var normal_note = preload("res://materials/note_type_stuff/normal_note.tres")
var climb_note = preload("res://materials/note_type_stuff/climb_note.tres")

func _ready():
	_set_position()
	
func _process(_delta: float) -> void:
	collect()

	if not is_collected:
		if global_position.z < -4.6:
			hide()
		else:
			show()
		if global_position.z > 0 and missed == false:
			missed = true
			MainLoader.current_combo = 0

func _set_position():
	var x_pos : float
	var y_pos : float
	var rot_x : float

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
			rot_x = 0
		2:
			y_pos = 0.6
			rot_x = deg_to_rad(180)

	position = Vector3(x_pos, y_pos, -pos)
	rotation.x = rot_x

	if type == 2:
		note_mesh.set_surface_override_material(0, climb_note)

		var climb_mesh = $ClimbNoteMesh
		climb_mesh.show()

func collect():
	if not is_collected:
		if is_hit and picker:
			if picker.is_collecting:
				is_collected = true
				picker.is_collecting = false
				picker.just_collected = true
				picker.note_just_hit = type
				picker.spawn_effect()

				var distance = abs(global_position.z + 0.8)

				if distance > 0.16:
					MainLoader.current_combo = 0
				else:
					MainLoader.current_combo += 1

				if distance <= 0.24:
					level = 1
				if distance <= 0.18:
					level = 2
				if distance <= 0.12:
					level = 3

				MainLoader.current_accuracy = level
				MainLoader.current_note_number += 1
				MainLoader.score += (level + 0.5) * 50
				print(MainLoader.score)

				hide()

func _on_area_3d_entered(area: Area3D) -> void:
	if area.is_in_group("picker"):
		is_hit = true
		picker = area.get_parent()

func _on_area_3d_exited(area: Area3D) -> void:
	if area.is_in_group("picker"):
		is_hit = false
		picker = null
