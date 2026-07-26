extends Node3D

@onready var area = $Area3D
@onready var label = $Label3D
var in_frame = false
var target_enter = 1.25
var target_exit = 1.0

func animate():
	area.mouse_entered.connect(func():
		in_frame = true
	)
	area.mouse_exited.connect(func():
		in_frame = false
	)

func _process(_delta: float) -> void:
	if in_frame:
		scale.x = lerp(scale.x, target_enter, 0.25)
		scale.y = lerp(scale.y, target_enter, 0.25)
	else:
		scale.x = lerp(scale.x, target_exit, 0.25)
		scale.y = lerp(scale.y, target_exit, 0.25)
