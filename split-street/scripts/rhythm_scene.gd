extends Node3D

var bar_scene = preload("res://scenes/bar_scene.tscn")
var bars = []
@onready var bars_node = $Bars
var bar_spacing
var current_location
var speed

func setup(game):
	speed = Vector3(0, 0, game.speed)
	bar_spacing = game.bar_spacing
	current_location = Vector3(0, 0, -bar_spacing)

	bars_node.position = Vector3(0, 0, -bar_spacing * 0.5)

	add_bars()

func _process(delta):
	bars_node.position += speed * delta

	for bar in bars:
		if bar.position.z + bars_node.position.z >= bar_spacing:
			MainLoader.set_number("bar", "add", 0)
			remove_bar(bar)
			add_bar()

func add_bar():
	var bar = bar_scene.instantiate()
	bar.position = Vector3(current_location.x, current_location.y, current_location.z)
	bars.append(bar)
	bars_node.add_child(bar)
	current_location -= Vector3(0, 0, bar_spacing)

func remove_bar(bar):
	bar.queue_free()
	bars.erase(bar)

func add_bars():
	for i in range(3):
		MainLoader.set_number("bar", "add", 0)
		add_bar()
