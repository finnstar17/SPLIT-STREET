extends Node3D

func get_jasons(folder): # get it haha no okay ☹️
    var matched_files: Array[String] = []

    var all_files = DirAccess.get_files_at(folder)

    for file_name in all_files:
        if file_name.get_extension() == "json":
            var full_path = folder.path_join(file_name)
            matched_files.append(full_path)
            
    return matched_files

func _ready() -> void:
    var all_files = get_jasons("res://music_related/charts")
    print(all_files)