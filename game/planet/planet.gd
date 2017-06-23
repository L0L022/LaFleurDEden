extends StaticBody2D

var gravity_zone = null#get_node("gravity_zone/collision").get_shape()

func _ready():
	gravity_zone = get_node("gravity_zone/collision").get_shape()