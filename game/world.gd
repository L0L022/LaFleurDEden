extends Node2D

var player = null
var song_player = null
var song_anim = null

const STATE_UP = 0
const STATE_LOW = 1
var state = -1
var last_song = ""

func _ready():
	player = get_node("player")
	song_player = get_node("sounds/song_player")
	song_anim = get_node("sounds/song_anim")

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
		song_player.play(name)
#		last_song = name
#		state = STATE_LOW
#		song_anim.play("low")

func _on_song_anim_finished():
	pass
#	print(state)
#	if state == STATE_LOW:
#		song_player.stop_all()
#		song_player.play(last_song)
#		print("play: ", last_song)
#		
#		state = STATE_UP
#		song_anim.play("up")
