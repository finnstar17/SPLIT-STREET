extends Node

# just an autoload script

var current_bar = 0

func add_bar():
    current_bar += 1
    print(str(current_bar))

func set_bar(number : int):
    current_bar = number