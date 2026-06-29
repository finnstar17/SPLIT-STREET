extends Node

var current_accuracy : int
var current_combo = 0

func set_accuracy(new_accuracy : int):
    current_accuracy = new_accuracy

func add_combo():
    current_combo += 1

func set_combo(new_combo : int):
    current_combo = new_combo