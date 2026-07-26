extends MeshInstance3D

var mat : StandardMaterial3D = get_active_material(0)
var speed = 0.1

func _process(delta : float):
	mat.uv1_offset.x -= speed * delta
	mat.uv1_offset.y += speed * delta
	
