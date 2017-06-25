extends Node2D

var sprites = ["foot_back", "arm_back", "body", "head", "foot_front", "arm_front"]
var images = {
	"foot_back": "neo_piedG",
	"arm_back": "neo_brasG",
	"body": "neo_buste",
	"head": "neo_tete",
	"foot_front": "neo_piedD",
	"arm_front": "neo_brasD"
}
var colors = ["", "_LALA", "_M", "_R", "_RR", "_V", "_W"]

var anim = null
var happy = false

func _ready():
	anim = get_node("anim")
	
	randomize()
	var color = rand_range(0, colors.size())
	for sprite_name in sprites:
		get_node(sprite_name).set_texture(load("res://art/"+images[sprite_name]+colors[color]+".tex"))
	
	if int(rand_range(0, 2)) == 0:
		set_scale(get_scale() * Vector2(-1, 1))
	
	_on_anim_timer_timeout()

func _on_neo_body_enter(body):
	if (not happy and body extends preload("res://heart/heart.gd")):
		happy = true
		print("happy")

func _on_anim_timer_timeout():
	anim.stop_all()
	var anims = anim.get_animation_list()
	anim.play(anims[int(randf()*10)%anims.size()])
