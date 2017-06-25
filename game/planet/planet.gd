extends StaticBody2D

export(int) var gravity_speed = 80

func _on_gravity_zone_body_enter(body):
	if (body extends preload("res://player/player.gd")):
		body.gravity = get_pos()
		body.gravity_speed = gravity_speed

func _on_gravity_zone_body_exit(body):
	if (body extends preload("res://player/player.gd")):
		body.gravity = Vector2()
