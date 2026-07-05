extends Node3D

@export_range(0, 4) var line : int
@export_range(0, 2) var plane : int
var pos = 0
var is_hit = false
var is_collected = false
var grant_point = false

func _ready():
	_set_position()
	
#func _process(_delta: float) -> void:
	#collect()

	#if not is_collected:
		#if global_position.z < -4.6:
			#hide()
		#else:
			#show()
			
func _set_position():
	var x_pos : float
	var y_pos : float

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
		2:
			y_pos = 0.6

	position = Vector3(x_pos, y_pos, -pos)

func collect():
	if not is_collected:
		is_collected = true

		if grant_point:
			MainLoader.score += 25
			print(MainLoader.score)

		queue_free()

func _on_area_3d_hold_entered(area: Area3D) -> void:
	if area.is_in_group("picker"):
		var picker = area.get_parent()
		if picker.general_collecting:
			collect()
