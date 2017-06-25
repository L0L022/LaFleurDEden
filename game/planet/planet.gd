extends StaticBody2D

var gravity_zone = null#get_node("gravity_zone/collision").get_shape()

func _ready():
	gravity_zone = get_node("gravity_zone/collision").get_shape()
	print("planet")

func _on_gravity_zone_body_enter(body):
	if (body extends preload("res://player/player.gd")):
		body.gravity = get_pos()

func _on_gravity_zone_body_exit(body):
	if (body extends preload("res://player/player.gd")):
		body.gravity = Vector2()
