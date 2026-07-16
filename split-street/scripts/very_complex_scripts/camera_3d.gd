extends Camera3D

var old_bar = 0
var new_bar = 0

@export var noise = FastNoiseLite.new()
var time = 0.0

func _process(delta: float) -> void:
	var main_bar = MainLoader.bar_detected
	new_bar = main_bar
	if new_bar != old_bar:
		old_bar = new_bar
		global_position.z = 0.2
	
	global_position.z = lerp(global_position.z, 0.25, MainLoader.current_speed * delta)

	var strength = 0.0
	var freq = 0.0
	time += delta * freq

	if MainLoader.game_mode == "in_game":
		strength = 2.0
		freq = 5.0
	elif MainLoader.game_mode == "menu":
		strength = 2.0
		freq = 10.0

	time += delta * freq
	
	rotation_degrees.x = noise.get_noise_1d(time) * strength
	rotation_degrees.y = noise.get_noise_1d(time + 1000) * strength
	rotation_degrees.z = noise.get_noise_1d(time + 2000) * strength

