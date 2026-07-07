extends Node3D

@onready var workspace = preload("res://scenes/workspace.tscn")

func _ready() -> void:
    var new_workspace = workspace.instantiate()
    add_child(new_workspace)