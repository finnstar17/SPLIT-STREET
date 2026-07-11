extends Camera3D

var old_bar = 0
var new_bar = 0

@export var noise = FastNoiseLite.new()
var strength = 2
var freq = 5.0
var time = 0.0

func _process(delta: float) -> void:
	var main_bar = MainLoader.bar_detected
	new_bar = main_bar
	if new_bar != old_bar:
		old_bar = new_bar
		global_position.z = 0.2
	
	global_position.z = lerp(global_position.z, 0.25, MainLoader.current_speed * delta)
	if MainLoader.game_mode == "in_game":
		time += delta * freq

		rotation_degrees.x = noise.get_noise_1d(time) * strength
		rotation_degrees.y = noise.get_noise_1d(time + 60) * strength
		rotation_degrees.z = noise.get_noise_1d(time + 120) * strength
