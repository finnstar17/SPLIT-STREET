extends Node3D

var bar_scene = preload("res://scenes/bar_scene.tscn")
var bill_scene = preload("res://scenes/hit_billboard.tscn")
var bars = []
@onready var bars_node = $Bars
var bar_spacing
var current_location
var speed
var old_note = 0

func setup(game):
	speed = Vector3(0, 0, game.speed)
	bar_spacing = game.bar_spacing
	current_location = Vector3(0, 0, -bar_spacing)

	bars_node.position = Vector3(0, 0, -bar_spacing * 0.5)

	add_bars()

func _process(delta):
	bars_node.position += speed * delta

	for bar in bars:
		if bar.global_position.z >= -1 and bar.detected == false:
			bar.detected = true
			MainLoader.bar_detected += 1
		if bar.position.z + bars_node.position.z >= bar_spacing:
			MainLoader.current_bar += 1
			remove_bar(bar)
			add_bar()
	
	var current_note = MainLoader.current_note_number
	if old_note != current_note:
		old_note = current_note

		spawn_bill()

func spawn_bill():
	var billboard = bill_scene.instantiate()
	var rigidbody = billboard.get_node("RigidBody3D")
	var collision_shape = rigidbody.get_node("CollisionShape3D")
	var sprite = collision_shape.get_node("Sprite3D")
	add_child(billboard)
	billboard.position = Vector3(0, 0, -1)

	if MainLoader.current_accuracy == 0:
		sprite.texture = load("res://images/okbill.png")
	elif MainLoader.current_accuracy == 1:
		sprite.texture = load("res://images/goodbill.png")
	elif MainLoader.current_accuracy == 2:
		sprite.texture = load("res://images/greatbill.png")
	elif MainLoader.current_accuracy == 3:
		sprite.texture = load("res://images/perfectbill.png")

	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 0.5)
	tween.finished.connect(func(): self.remove_child(billboard))


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
		MainLoader.current_bar += 1
		add_bar()
