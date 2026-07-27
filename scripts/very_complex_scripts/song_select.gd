extends Node3D

@onready var all_songs = $AllSongs
@onready var player = $AudioStreamPlayer
var template = preload("res://scenes/select_template.tscn")
var all_jasons

func get_jasons(folder): # get it haha no okay :(
	var matched_files: Array[String] = []
	var all_files = DirAccess.get_files_at(folder)

	for file_name in all_files:
		if file_name.get_extension() == "json":
			var full_path = folder.path_join(file_name)
			matched_files.append(full_path)
			
	return matched_files

func _ready() -> void:
	var index = 0
	all_jasons = get_jasons("res://music_related/charts")

	for file_name : String in all_jasons:
		var new_temp = template.instantiate()
		new_temp.position.x += index * 1.25
		new_temp.position.z = -0.5

		var file_name_base = file_name.get_file().get_basename()
		var chart = MainLoader.load_chart(file_name)
		if chart:
			print("yessir")

		var song_cover = new_temp.get_node("SongCover")
		var song_name : Label3D = new_temp.get_node("SongName")
		var artist : Label3D = new_temp.get_node("Artist")
		var mat = song_cover.get_active_material(0)
		var new_cover = load(chart["cover"])
		mat.albedo_texture = new_cover
		song_name.text = file_name_base

		await get_tree().process_frame

		var aabb = song_name.get_aabb() # learning so much yo
		artist.position.y += aabb.position.y * 0.2
		artist.text = chart["artist"]
			
		new_temp.name = file_name_base
		all_songs.add_child(new_temp)
		chart = null # i dunno yo
		
		index += 1

func _process(_delta: float) -> void:
	var old_song = player.stream

	for song : Node3D in all_songs.get_children():
		var distance = abs(song.global_position.x - get_parent().get_node("Camera3D").global_position.x)
		if distance < 3:
			var mapped_dist = remap(distance, 0.0, 3.0, 1.0, 0.0)
			song.position.z = -0.5
			song.position.z = lerp(song.position.z, 0.0, mapped_dist)
			if distance < 0.1:
				var path = "res://music_related/music".path_join(song.name) + ".mp3"
				var current_song = load(path)
				if FileAccess.file_exists(path):
					if old_song != current_song:
						player.stream = current_song
						player.play(20.0)
						player.volume_db = -80.0
						fade_volume(0.0)

func fade_volume(volume : float):
	var volume_tween = player.create_tween()
	volume_tween.tween_property(player, "volume_db", volume, 1)
