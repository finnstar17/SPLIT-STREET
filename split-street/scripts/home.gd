extends Node3D

@onready var workspace = preload("res://scenes/workspace.tscn")
@onready var main_menu = $MainMenu
@onready var menu_music = $MainMenu/AudioStreamPlayer
@onready var intro_card = $IntroCard
@onready var intro_text = $IntroCard/CanvasLayer/Label
@onready var hooray = $Hooray
var started = false
var can_play = false
var finished = false

func _ready() -> void:
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

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if not started and can_play:
				started = true
				fade(1)

				var volume_tween = menu_music.create_tween()
				volume_tween.tween_property(menu_music, "volume_db", -80.0, 0.5)

				await get_tree().create_timer(0.5).timeout # yeah nah why in the world is this SO long.
				fade(0)

				main_menu.queue_free()
				MainLoader.game_mode = "in_game"

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
		hooray.play()
		intro_text.text = "thanks for playing the demo!"
