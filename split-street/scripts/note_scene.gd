extends Node3D

var idle_note = preload("res://materials/note_materials/idle_note_material.tres")
var active_note = preload("res://materials/note_materials/active_note_material.tres")

@export_range(0, 8) var line : int
@onready var note_mesh = $NoteMesh
@onready var note_effect = preload("res://scenes/note_effect.tscn")
@onready var climb_note = preload("res://scenes/more_complex_scenes/climb_note_scene.tscn")

var is_pressed = false
var is_collecting = false
var general_collecting = false
var just_collected = false
var note_just_hit : int
const ACTION_MAP = {
	1: "D_Input",
	2: "F_Input",
	3: "J_Input",
	4: "K_Input",
	5: "E_Input",
	6: "R_Input",
	7: "U_Input",
	8: "I_Input"
}

func _ready():
	note_mesh.set_surface_override_material(0, idle_note)

func _process(_delta: float) -> void:
	if just_collected:
		just_collected = false
		
		var effect = note_effect.instantiate()
		add_child(effect)

	if Input.is_action_just_pressed(ACTION_MAP[line]):
		is_pressed = true
		is_collecting = true
		general_collecting = true

		note_mesh.set_surface_override_material(0, active_note)
	elif Input.is_action_just_released(ACTION_MAP[line]):
		is_pressed = false
		is_collecting = false
		general_collecting = false

		note_mesh.set_surface_override_material(0, idle_note)

func spawn_effect():
	if note_just_hit == 2:
		var new_note = climb_note.instantiate()
		get_parent().add_child(new_note)
		new_note.position = position
		new_note.just_came_from = self

		if new_note.position.y > 0:
			new_note.direction = -1
		else:
			new_note.direction = 1