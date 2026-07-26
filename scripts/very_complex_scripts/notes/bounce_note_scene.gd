extends Node3D

var is_hit = false
var is_collected = false
var level = 0
var picker : Node3D
var direction : int
var last_song_pos = MainLoader.delta
var can_hit = false
var moving_down = false

func _ready() -> void:
	var current_pos = global_position.y
	var time = MainLoader.quarter_note / 2
	var tween_1 = create_tween()
	tween_1.set_trans(Tween.TRANS_SINE)
	tween_1.set_ease(Tween.EASE_OUT)
	tween_1.tween_property(self, "position:y", current_pos + (0.45 * direction), time)
	tween_1.finished.connect(func():
		can_hit = true

		var tween_2 = create_tween()
		tween_2.set_trans(Tween.TRANS_SINE)
		tween_2.set_ease(Tween.EASE_IN)
		tween_2.tween_property(self, "position:y", current_pos, time)
		tween_2.finished.connect(func():
			moving_down = true
		)
	)

func _process(delta: float) -> void:
	if moving_down:
		var speed = MainLoader.current_speed / 1.5 # i dunno what's up with the code but dividing it makes it faster for some reason
		position += Vector3(0, 4.8 * (delta / speed) * -direction, 0) # negative direction because it's moving back down to the position it just came from eek
	
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

func _on_area_3d_bounce_exited(area: Area3D) -> void:
	if area.is_in_group("picker") and area.get_parent() and can_hit:
		is_hit = false
		picker = null

func _on_area_3d_bounce_entered(area: Area3D) -> void:
	if area.is_in_group("picker") and area.get_parent() and can_hit:
		is_hit = true
		picker = area.get_parent()
