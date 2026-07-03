extends Node3D

@onready var scale_mesh = $ScaleMesh
@onready var gradient_mesh = $CylinderMesh

var duration = 0.4

func _ready():
	var tween_scale = scale_mesh.create_tween()
	tween_scale.tween_property(scale_mesh, "scale", Vector3(0.6, 0.6, 0.6), duration)

	tween_transparency(scale_mesh)
	tween_transparency(gradient_mesh)

	tween_scale.finished.connect(func(): queue_free())
	
func tween_transparency(mesh : MeshInstance3D):
	var mat = mesh.get_active_material(0)
	if mat:
		var tween = create_tween()
		tween.tween_property(mat, "albedo_color", Color(0, 0, 0, 0.0), duration)
