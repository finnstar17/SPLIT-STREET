extends Node3D

@onready var music_node = $Music
@onready var main_scene = $RhythmScene
@onready var stat_scene = $PreviewStats

@onready var time_stuff = $PreviewStats/SongPreview/CurrentTime
@onready var bar_timeline = $PreviewStats/SongPreview/Bar/Node3D
@onready var actual_score = $PreviewStats/Stats/ActualScore
@onready var actual_combo = $PreviewStats/Stats/ActualCombo

@onready var perfects = $PreviewStats/Stats/RealAccuracy/PerfectLabel
@onready var greats = $PreviewStats/Stats/RealAccuracy/GreatLabel
@onready var goods = $PreviewStats/Stats/RealAccuracy/GoodLabel
@onready var oks = $PreviewStats/Stats/RealAccuracy/OkLabel
@onready var misseds = $PreviewStats/Stats/RealAccuracy/MissedLabel

var audio
var charts = "res://music_related/charts/"

var tempo
var bar_spacing
var quarter_time_sec
var speed
var start_pos
var current_bar = 0

var speed_without_distance

var song_name
var artist
var cover

func _ready() -> void:
	var song = charts.path_join("Trick Room.json")
	load_song(song)

func _process(delta: float) -> void:
	if current_bar != MainLoader.bar_detected:
		current_bar = MainLoader.bar_detected
		stat_scene.scale.x = 0.97
	stat_scene.scale.x = lerp(stat_scene.scale.x, 1.0, MainLoader.current_speed * delta * 2)

	time_stuff.text = MainLoader.current_time + " / " + MainLoader.full_length
	bar_timeline.scale.x = MainLoader.time_in_sec / float(MainLoader.length_in_sec)

	actual_score.text = str(int(MainLoader.score))
	actual_combo.text = str(MainLoader.current_combo) + "x"

	perfects.text = str(int(MainLoader.perfects))
	greats.text = str(int(MainLoader.greats))
	goods.text = str(int(MainLoader.goods))
	oks.text = str(int(MainLoader.oks))
	misseds.text = str(int(MainLoader.misseds))

func load_song(song_path):
	var chart_data = MainLoader.load_chart(song_path)
	var song = chart_data["file"]

	song_name = chart_data.title
	artist = chart_data.artist
	cover = chart_data.cover
	stat_scene.set_preview_stats(self)

	audio = load(song)
	MainLoader.set_current_song(song_path)

	calc_params(chart_data["bpm"], chart_data["spacing"], chart_data["offset"])
	MainLoader.current_speed = speed_without_distance

	music_node.setup(self)
	main_scene.setup(self)

func calc_params(t, b, s):
	tempo = t
	bar_spacing = b
	quarter_time_sec = 60 / float(tempo)
	speed_without_distance = float(4 * quarter_time_sec)
	speed = bar_spacing / speed_without_distance
	start_pos = s
