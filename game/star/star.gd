extends Area2D

var taken = false

func _on_body_enter(body):
	if (not taken and body extends preload("res://player/player.gd")):
		taken = true
		var smoke = body.smoke
		smoke.set_lifetime(smoke.get_lifetime() + 0.01)
		smoke.set_amount(100*smoke.get_lifetime()/0.1)
		get_node("anim").play("taken")