extends Node3D

var type = "static"
var current_bar = 0
var bound = preload("res://scenes/road_boundary.tscn")
var duration = 0.8

func _process(_delta: float) -> void:
	if type == "static":
		if current_bar != MainLoader.bar_detected:
			current_bar = MainLoader.bar_detected
			spawn_anim()
	elif type == "anim":
		return

func spawn_anim():
	var new_bound = bound.instantiate()
	new_bound.type = "anim"
	add_child(new_bound)
	
	var tween_move = new_bound.create_tween()
	tween_move.set_trans(Tween.TRANS_CUBIC)
	tween_move.set_ease(Tween.EASE_OUT)
	tween_move.tween_property(new_bound, "position:x", -0.2, duration)

	var tween_scale = new_bound.create_tween()
	tween_scale.tween_property(new_bound, "scale:x", 0.01, duration)

	tween_transparency(new_bound.get_node("MeshInstance3D"))

	tween_scale.finished.connect(func(): new_bound.queue_free())

func tween_transparency(mesh : MeshInstance3D):
	var mat = mesh.get_active_material(0)
	if mat:
		var tween = create_tween()
		tween.tween_property(mat, "albedo_color", Color(0, 0, 0, 0.0), duration)
