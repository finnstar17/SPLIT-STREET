extends Node3D

var template = preload("res://scenes/select_template.tscn")
var all_jasons

func get_jasons(folder): # get it haha no okay ☹️
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

	for file_name in all_jasons:
		var new_temp = template.instantiate()
		new_temp.position.x += index * 1.25
		add_child(new_temp)

		if file_name.get_extension() == "mp3":
			var corresponding_file = "res://music_related/music".path_join(file_name)
			
			if FileAccess.file_exists(corresponding_file):
				pass # Your logic here
		
		index += 1
