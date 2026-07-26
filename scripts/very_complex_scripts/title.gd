extends Node3D

var total_time = 0
var size_change = 0.003
var speed = 2

func _process(delta: float) -> void:
    total_time += delta

    var size_val_x = sin(total_time * speed) + 1
    var size_val_y = sin((total_time - 2) * speed) + 1

    scale = Vector3(0.175 + (size_val_x * size_change), 0.175 + (size_val_y * size_change), 1)