extends Node3D

@onready var workspace = preload("res://scenes/workspace.tscn")
@onready var song_select = preload("res://scenes/song_select.tscn")
@onready var main_menu = $MainMenu
@onready var menu_music = $MainMenu/AudioStreamPlayer
@onready var intro_card = $IntroCard
@onready var intro_text = $IntroCard/CanvasLayer/Label
@onready var hooray = $Hooray
@onready var pause_menu = $PauseMenu
var started = false
var can_play = false
var finished = false
var skip_intro = false
var playing = false
var paused = false

func _ready() -> void:
	if not skip_intro:
		await get_tree().create_timer(1).timeout
		menu_music.play()
		await get_tree().create_timer(1).timeout
		intro_text.text = "finnstar17 presents"
		await get_tree().create_timer(1.4).timeout
		intro_text.text = "for horizons arcana :3"
		await get_tree().create_timer(1.4).timeout
		print("lets go")

	intro_text.text = ""
	fade(0)
	can_play = true

func start():
	if not started and can_play:
		started = true
		fade(1)

		var volume_tween = menu_music.create_tween()
		volume_tween.tween_property(menu_music, "volume_db", -80.0, 0.5)

		await get_tree().create_timer(0.5).timeout # yeah nah why in the world is this SO long.
		fade(0)

		main_menu.queue_free()

		var new_select = song_select.instantiate()
		add_child(new_select)

		#var new_workspace = workspace.instantiate()
		#add_child(new_workspace)

func play_game():
	if not playing:
		playing = true
		fade(1)

		await get_tree().create_timer(0.5).timeout
		fade(0)

		MainLoader.game_mode = "in_game"

		var current_song_select = get_node("SongSelect")
		current_song_select.queue_free()

		var new_workspace = workspace.instantiate()
		add_child(new_workspace)
			
func fade(transparency : float):
	var color_rect = $IntroCard/CanvasLayer/ColorRect
	var tween = color_rect.create_tween()
	tween.tween_property(color_rect, "modulate:a", transparency, 0.5)

func _process(_delta: float) -> void:
	if MainLoader.congrats and not finished:
		finished = true
		fade(1)
		await get_tree().create_timer(2).timeout
		finished = false
		exit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if MainLoader.game_mode == "in_game":
			var current_workspace = get_node("Workspace3D")
			if not current_workspace.get_tree().paused:
				current_workspace.get_tree().paused = true
				pause_menu.show()

func continue_game():
	if MainLoader.game_mode == "in_game":
		var current_workspace = get_node("Workspace3D")
		if current_workspace.get_tree().paused:
			current_workspace.get_tree().paused = false
			pause_menu.hide()

func exit():
	if MainLoader.game_mode == "in_game":
		fade(1)

		await get_tree().create_timer(0.5).timeout
		fade(0)

		var current_workspace = get_node("Workspace3D")
		current_workspace.get_tree().paused = false
		current_workspace.queue_free()
		pause_menu.hide()

		MainLoader.game_mode = "menu"
		MainLoader.reset()
		playing = false

		var new_select = song_select.instantiate()
		add_child(new_select)
