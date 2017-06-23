extends RigidBody2D

func _ready():
	get_node("anim").play("ready")
