extends StaticBody2D

var gravity_zone = null#get_node("gravity_zone/collision").get_shape()

func _ready():
	print("a")
	gravity_zone = get_node("gravity_zone/collision").get_shape()
	set_process(true)
	
func _process(delta):
	print(get_shape(0))