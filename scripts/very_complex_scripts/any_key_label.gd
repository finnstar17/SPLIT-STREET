extends Label3D

func _ready() -> void:
	while true:
		fade(1)
		await get_tree().create_timer(2).timeout
		fade(0)
		await get_tree().create_timer(2).timeout

func fade(transparency_e : float):
	var tween = self.create_tween()
	tween.tween_property(self, "modulate:a", transparency_e, 2)