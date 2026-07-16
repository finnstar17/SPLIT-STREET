extends Node3D

var is_hit = false
var is_collected = false
var level = 0
var picker : Node3D
var direction : int
var just_came_from : Node3D
var last_song_pos = MainLoader.delta

func _process(delta: float) -> void:
	var speed = MainLoader.current_speed
	var new_delta = MainLoader.delta - last_song_pos
	last_song_pos = MainLoader.delta
	position += Vector3(0, (4.8 * new_delta) / speed * direction, 0)

	collect()

	if not is_collected:
		if global_position.y >= 1.2 or global_position.y <= -1.2:
			queue_free()
			MainLoader.current_combo = 0
			MainLoader.misseds += 1

func collect():
	if not is_collected:
		if is_hit and picker:
			if picker.is_collecting:
				is_collected = true
				picker.is_collecting = false
				picker.just_collected = true

				var distance = abs(abs(global_position.y) - 0.6)

				if distance >= 0.25:
					MainLoader.current_combo = 0
				else:
					MainLoader.current_combo += 1

				if distance <= 0.2:
					level = 1
				if distance <= 0.15:
					level = 2
				if distance <= 0.1:
					level = 3

				if level == 0:
					MainLoader.oks += 1
				elif level == 1:
					MainLoader.goods += 1
				elif level == 2:
					MainLoader.greats += 1
				elif level == 3:
					MainLoader.perfects += 1

				MainLoader.current_accuracy = level
				MainLoader.current_note_number += 1
				MainLoader.score += (level + 0.5) * 50
				print(MainLoader.score)

				queue_free()

func _on_area_3d_climb_exited(area: Area3D) -> void:
	if area.is_in_group("picker") and area.get_parent() != just_came_from:
		is_hit = false
		picker = null

func _on_area_3d_climb_entered(area: Area3D) -> void:
	if area.is_in_group("picker") and area.get_parent() != just_came_from:
		is_hit = true
		picker = area.get_parent()