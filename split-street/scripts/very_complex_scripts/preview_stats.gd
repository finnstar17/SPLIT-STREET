extends Node3D

@onready var song_name = $SongPreview/SongName
@onready var artist = $SongPreview/Artist
@onready var song_cover = $SongPreview/SongCover

func set_preview_stats(game : Node3D):
    song_name.text = game.song_name
    artist.text = game.artist

    var mat = song_cover.get_active_material(0)
    var new_cover = load(game.cover)
    if mat:
        mat.albedo_texture = new_cover