extends Node3D

var total_time = randi_range(0, 5) * 2
var speed = 2
var current_size : float
var size_change : float

func _ready() -> void:
	current_size = scale.x
	size_change = current_size * 0.01

func _process(delta: float) -> void:
	total_time += delta * randf_range(1.0, 1.2)

	var size_val_x = sin(total_time * speed) + 1
	var size_val_y = sin((total_time - 2) * speed) + 1

	scale = Vector3(current_size + (size_val_x * size_change), current_size + (size_val_y * size_change), 1)
