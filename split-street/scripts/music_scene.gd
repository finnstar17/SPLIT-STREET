extends Node3D

@onready var player = $AudioStreamPlayer

var speed
var started = false
var pre_start
var start_pos

var song_pos = 0.0

func _ready() -> void:
	pass

func setup(game):
	player.stream = game.audio

	speed = game.speed
	started = false
	pre_start = game.bar_spacing
	start_pos = game.start_pos
	
	var floored_time = floor(player.stream.get_length())
	var new_time = seconds_to_minutes(floored_time)
	MainLoader.full_length = new_time
	MainLoader.length_in_sec = floored_time

func start():
	started = true
	player.play(start_pos)
	MainLoader.started = true

func _process(delta: float) -> void:
	if not started:
		pre_start -= speed * delta
		if pre_start <= 0:
			start()
	
	var floored_time = floor(player.get_playback_position())
	var new_time = seconds_to_minutes(floored_time)
	MainLoader.current_time = new_time
	MainLoader.time_in_sec = floored_time

	var base_pos = player.get_playback_position()
	var last_mix = AudioServer.get_time_since_last_mix()
	var latency = AudioServer.get_output_latency()
	var time = base_pos + last_mix - latency
	song_pos = max(song_pos, time)
	MainLoader.delta = song_pos


func seconds_to_minutes(seconds : float):
	var minutes = floor(seconds / 60.0)
	var remaining_seconds = fmod(seconds, 60.0)
	var min_string = str(int(minutes))
	var rs_string = str(int(remaining_seconds))

	if remaining_seconds < 10:
		rs_string = "0" + rs_string

	return min_string + ":" + rs_string
