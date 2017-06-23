extends Node2D

var player = null
var song_player = null

func _ready():
	player = get_node("player")
	song_player = get_node("sounds/song_player")

func _on_jungle_body_enter(body):
	play_song(body, "jungle")


func _on_desert_body_enter(body):
	play_song(body, "desert")


func _on_garden_body_enter(body):
	play_song(body, "jardin")


func _on_garden_zen_body_enter(body):
	play_song(body, "jardin_zen")


func _on_snow_body_enter(body):
	play_song(body, "neige")


func _on_void_body_enter(body):
	play_song(body, "troploin")

func play_song(body, name):
	if (body extends preload("res://player/player.gd")):
		song_player.stop_all()
		song_player.play(name)