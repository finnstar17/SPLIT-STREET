extends Node3D

@onready var accuracy_label : Label3D = $AccuracyLabel
@onready var combo_label : Label3D = $ComboLabel

var old_note = 0
var old_combo = 0
var fade_speed = 0.03

func _ready() -> void:
	accuracy_label.text = ""
	combo_label.text = ""

func _process(_delta: float) -> void:
	var current_note_number = MainLoader.current_note_number
	var current_accuracy = MainLoader.current_accuracy
	var current_combo = MainLoader.current_combo
	var accuracy_string = ""

	accuracy_label.transparency += fade_speed
	combo_label.transparency += fade_speed

	if current_accuracy == 0:
		accuracy_string = "OK!"
	elif current_accuracy == 1:
		accuracy_string = "GOOD!"
	elif current_accuracy == 2:
		accuracy_string = "GREAT!"
	elif current_accuracy == 3:
		accuracy_string = "PERFECT!"

	if old_note != current_note_number:
		old_note = current_note_number
		accuracy_label.transparency -= 1
		accuracy_label.text = accuracy_string
	if old_combo != current_combo:
		old_combo = current_combo
		combo_label.transparency -= 1
		combo_label.text = str(current_combo)
