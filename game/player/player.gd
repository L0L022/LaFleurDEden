extends KinematicBody2D

const STATE_GROUND = 0
const STATE_AIR = 1
var state = -1

const SPEED = 100
const SPEED_MAX = 500
const JUMP_FORCE = 80
var velocity = Vector2()

var gravity = Vector2(491, 292)
var gravity_speed = 600

var ground_normal = Vector2()

var raycast = null

func _ready():
	raycast = get_node("raycast")
	raycast.add_exception(self)
	set_fixed_process(true)

func _fixed_process(delta):
	if raycast.is_colliding():
		state = STATE_GROUND
	else:
		state = STATE_AIR

	velocity.y += gravity_speed * delta
	
	if state == STATE_GROUND and Input.is_action_pressed("ui_up"):
		velocity.y -= JUMP_FORCE
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
	else:
		velocity.x = 0
	
	var motion = velocity * delta
	
	update_ground()
	var angle = ground_normal.angle_to(Vector2(0, 1))
	set_rot(angle)
	motion = motion.rotated(angle)
	
	motion = move(motion)
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		velocity = velocity.rotated(-angle)
		motion = move(motion)
		
		update_ground()
		var angle = ground_normal.angle_to(Vector2(0, 1))
		set_rot(angle)

func update_ground():
	ground_normal.x = get_pos().x - gravity.x
	ground_normal.y = gravity.y - get_pos().y
	ground_normal = ground_normal.normalized()
	