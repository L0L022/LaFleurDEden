extends RigidBody2D

const SPEED = 200
#const SPEED_MAX = 500
const JUMP_FORCE = 80
var velocity = Vector2()

var gravity = Vector2()
var gravity_speed = 80

var ground_normal = Vector2()

var shape = null
var smoke = null

func _ready():
	shape = get_node("shape").get_shape()
	smoke = get_node("smoke")
	set_fixed_process(true)

func _fixed_process(delta):
	update_gravity()
	update_ground()
	apply_impulse(Vector2(), -ground_normal * gravity_speed * delta)
	
	var velocity = Vector2()
	
	if(Input.is_action_pressed("ui_up")):
		velocity.y -= SPEED * delta
		smoke.set_emitting(true)
	else:
		smoke.set_emitting(false)
	
	if(Input.is_action_pressed("ui_down")):
		velocity.y += SPEED * delta
	if(Input.is_action_pressed("ui_right")):
		set_angular_velocity(0)
		rotate(-2*delta)
	if(Input.is_action_pressed("ui_left")):
		set_angular_velocity(0)
		rotate(2*delta)
	
	apply_impulse(Vector2(), velocity.rotated(get_rot()))

func update_gravity():
	gravity = Vector2()
	for planet in get_tree().get_nodes_in_group("planets"):
		if shape.collide(get_transform(), planet.gravity_zone, planet.get_transform()):
			gravity = planet.get_pos()

func update_ground():
	if gravity != Vector2():
		ground_normal = get_pos() - gravity
		ground_normal = ground_normal.normalized()
	else:
		ground_normal = Vector2()
	