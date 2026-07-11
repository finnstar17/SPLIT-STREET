extends Node3D

@onready var scale_mesh = $ScaleMesh
@onready var gradient_mesh = $CylinderMesh

var duration = 0.4

func _ready():
	var tween_scale = scale_mesh.create_tween()
	tween_scale.set_trans(Tween.TRANS_CUBIC)
	tween_scale.set_ease(Tween.EASE_OUT)
	tween_scale.tween_property(scale_mesh, "scale", Vector3(0.5, 0.5, 0.5), duration)

	tween_transparency(scale_mesh, 2)
	tween_transparency(gradient_mesh, 1)

	tween_scale.finished.connect(func(): queue_free())
	
func tween_transparency(mesh : MeshInstance3D, type : int):
	var mat = mesh.get_active_material(0)
	if mat:
		var tween = create_tween()
		if type == 2:
			tween.set_trans(Tween.TRANS_SINE)
			tween.set_ease(Tween.EASE_IN)
		tween.tween_property(mat, "albedo_color", Color(0, 0, 0, 0.0), duration)
