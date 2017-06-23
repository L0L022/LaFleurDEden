extends Node2D

var sprites = ["foot_back", "arm_back", "body", "head", "foot_front", "arm_front"]
var anim = null
var happy = false

func _ready():
	anim = get_node("anim")
	
	if int(rand_range(0, 2)) == 0:
		set_scale(get_scale() * Vector2(-1, 1))
	
	_on_timer_timeout()

func _on_timer_timeout():
	anim.stop_all()
	var anims = anim.get_animation_list()
	anim.play(anims[int(randf()*10)%anims.size()])

func _on_neo_body_enter(body):
	if (not happy and body extends preload("res://heart/heart.gd")):
		happy = true
		print("happy")
