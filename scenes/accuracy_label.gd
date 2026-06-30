extends Label3D

var old_combo = 0

func _process(_delta: float) -> void:
	var current_combo = AccuracyManager.current_combo
	var current_accuracy = AccuracyManager.current_accuracy
	var accuracy_string = ""

	transparency += 0.05

	if current_accuracy == 0:
		accuracy_string = "OK!"
	elif current_accuracy == 1:
		accuracy_string = "GOOD!"
	elif current_accuracy == 2:
		accuracy_string = "GREAT!"
	elif current_accuracy == 3:
		accuracy_string = "PERFECT!"

	if old_combo != current_combo:
		old_combo = current_combo
		transparency -= 1
		text = accuracy_string
	
