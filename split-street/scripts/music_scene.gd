extends Node3D

@onready var player = $AudioStreamPlayer

var speed
var started = false
var pre_start
var start_pos

func _ready() -> void:
	pass

func setup(game):
	player.stream = game.audio

	speed = game.speed
	started = false
	pre_start = game.bar_spacing
	start_pos = game.start_pos

func start():
	started = true
	player.play(start_pos)

func _process(delta: float) -> void:
	if not started:
		pre_start -= speed * delta
		if pre_start <= 0:
			start()
			return
