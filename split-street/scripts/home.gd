extends Node3D

@onready var workspace = preload("res://scenes/workspace.tscn")
@onready var main_menu = preload("res://scenes/main_menu.tscn")

func _ready() -> void:
    var new_menu = main_menu.instantiate()
    add_child(new_menu)

    await get_tree().create_timer(3.5).timeout
    fade(1)
    await get_tree().create_timer(0.5).timeout
    fade(0)

    new_menu.queue_free()

    var new_workspace = workspace.instantiate()
    add_child(new_workspace)

func fade(transparency : float):
    var color_rect = $BlackScreen/CanvasLayer/ColorRect
    var tween = color_rect.create_tween()
    tween.tween_property(color_rect, "modulate:a", transparency, 0.5)
