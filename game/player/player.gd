extends RigidBody2D

const SPEED = 200
#const SPEED_MAX = 500
const JUMP_FORCE = 80
var velocity = Vector2()

var gravity = Vector2()
var gravity_speed = 80

var ground_normal = Vector2()
var heart = preload("res://heart/heart.tscn")

var camera = null
var shape = null
var smoke = null
var stars = null
var shooting_star = null
var shoot_timer = null
var light = null

var can_shoot = true

func _ready():
	camera = get_node("camera")
	shape = get_node("shape").get_shape()
	smoke = get_node("smoke")
	stars = get_node("stars")
	shooting_star = get_node("shooting_star")
	shoot_timer = get_node("shoot_timer")
	light = get_node("light")
	
	stars.set_emission_half_extents(get_viewport_rect().size)
	shooting_star.set_emission_half_extents(get_viewport_rect().size)
	
	set_fixed_process(true)

func _fixed_process(delta):
	update_gravity()
	update_ground()
	apply_impulse(Vector2(), -ground_normal * gravity_speed * delta)
	
	var velocity = Vector2()
	
	if(Input.is_action_pressed("ui_up")):
		velocity.y -= SPEED * delta
		smoke.set_emitting(true)
		light.set_enabled(true)
	else:
		smoke.set_emitting(false)
		light.set_enabled(false)
	
	if(Input.is_action_pressed("ui_down")):
		velocity.y += SPEED * delta
	if(Input.is_action_pressed("ui_right")):
		set_angular_velocity(0)
		rotate(-2*delta)
	if(Input.is_action_pressed("ui_left")):
		set_angular_velocity(0)
		rotate(2*delta)
	
	apply_impulse(Vector2(), velocity.rotated(get_rot()))
	
	if can_shoot and Input.is_action_pressed("ui_accept"):
		can_shoot = false
		shoot_timer.start()
		var h = heart.instance()
		get_tree().get_root().add_child(h)
		h.add_collision_exception_with(self)
		h.set_pos(get_pos())
		h.apply_impulse(Vector2(), Vector2(0, -1).rotated(get_rot())*800)

func update_gravity():
	pass
#	gravity = Vector2()
#	for planet in get_tree().get_nodes_in_group("planets"):
#		if shape.collide(get_transform(), planet.gravity_zone, planet.get_transform()):
#			gravity = planet.get_pos()

func update_ground():
	if gravity != Vector2():
		ground_normal = get_pos() - gravity
		ground_normal = ground_normal.normalized()
	else:
		ground_normal = Vector2()

func _on_shoot_timer_timeout():
	can_shoot = true
