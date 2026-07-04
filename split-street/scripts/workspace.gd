extends Node3D

@onready var music_node = $Music
@onready var mainScene = $RhythmScene
@onready var camera = $Camera3D

var audio
var charts = "res://music_related/charts/"

var tempo
var bar_spacing
var quarter_time_sec
var speed
var start_pos
var current_bar = 0

var speed_without_distance

func _ready() -> void:
	var song = charts.path_join("Trick Room.json")
	load_song(song)

func _process(delta: float) -> void:
	if current_bar != MainLoader.bar_detected:
		current_bar = MainLoader.bar_detected
		camera.fov = 86.25
	
	camera.fov = lerp(camera.fov, 90.0, speed * delta)

func load_song(song_path):
	var chart_data = MainLoader.load_chart(song_path)
	var song = chart_data["file"]
	audio = load(song)
	MainLoader.set_current_song(song_path)

	calc_params(chart_data["bpm"], chart_data["spacing"], chart_data["offset"])
	MainLoader.current_speed = speed_without_distance

	music_node.setup(self)
	mainScene.setup(self)

func calc_params(t, b, s):
	tempo = t
	bar_spacing = b
	quarter_time_sec = 60 / float(tempo)
	speed_without_distance = float(4 * quarter_time_sec)
	speed = bar_spacing / speed_without_distance
	start_pos = s
