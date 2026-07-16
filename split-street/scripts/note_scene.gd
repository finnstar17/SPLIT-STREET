extends Node3D

var idle_note = preload("res://materials/note_materials/idle_note_material.tres")
var active_note = preload("res://materials/note_materials/active_note_material.tres")

@export_range(0, 8) var line : int
@onready var note_mesh = $NoteMesh
@onready var label = $Label3D
@onready var note_effect = preload("res://scenes/note_effect.tscn")
@onready var climb_note = preload("res://scenes/more_complex_scenes/climb_note_scene.tscn")

var is_collecting = false
var general_collecting = false
var just_collected = false
var note_just_hit : int
var current_note : Node3D
var last_note : Node3D
var just_missed = false
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

	if line == 1:
		label.text = "D"
	elif line == 2:
		label.text = "F"
	elif line == 3:
		label.text = "J"
	elif line == 4:
		label.text = "K"
	elif line == 5:
		label.text = "E"
	elif line == 6:
		label.text = "R"
	elif line == 7:
		label.text = "U"
	elif line == 8:
		label.text = "I" # dud i might know what im doing ✌️

	var tween = label.create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	var tween_transparency = tween.tween_property(label, "transparency", 1, 4)
	tween_transparency.finished.connect(func(): label.queue_free())


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(ACTION_MAP[line]):
		is_collecting = true
		general_collecting = true

		note_mesh.set_surface_override_material(0, active_note)
	elif Input.is_action_just_released(ACTION_MAP[line]):
		is_collecting = false
		general_collecting = false

		note_mesh.set_surface_override_material(0, idle_note)

	if current_note and is_collecting:
		is_collecting = false
		just_collected = true
		current_note.collect(self)

	if just_collected:
		just_collected = false
		
		var effect = note_effect.instantiate()
		add_child(effect)

	if last_note and last_note.global_position.z >= 0.3 and just_missed == false:
		just_missed = true
		MainLoader.current_combo = 0
		MainLoader.misseds += 1

func spawn_extra():
	if note_just_hit == 2:
		var new_note = climb_note.instantiate()
		get_parent().add_child(new_note)
		new_note.position = position
		new_note.just_came_from = self

		if new_note.position.y > 0:
			new_note.direction = -1
		else:
			new_note.direction = 1


func _on_area_3d_hit_exited(area: Area3D) -> void:
	if area.is_in_group("note"):
		current_note = null

func _on_area_3d_hit_entered(area: Area3D) -> void:
	if area.is_in_group("note"):
		current_note = area.get_parent()
		last_note = current_note
		just_missed = false
