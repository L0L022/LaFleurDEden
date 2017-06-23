extends StaticBody2D

var sprite = null
var shape = null
var shader = null

export (Texture) var planet_texture setget planet_texture_set
export (float) var planet_radius = 0 setget planet_radius_set

func _ready():
	sprite = get_node("sprite")
	shape = CircleShape2D.new()
	add_child(shape)

	shape.set_radius(planet_radius)
	sprite.set_texture(planet_texture)
	if planet_texture:
		sprite.set_scale(Vector2(
		planet_radius * 2 / planet_texture.get_width(),
		planet_radius * 2 / planet_texture.get_height()))
	
	be_in_background(true)

func planet_texture_set(value):
	if value and sprite:
		sprite.set_texture(value)
	planet_texture = value
	
func planet_radius_set(value):
	planet_radius = value
	if sprite and planet_texture:
		sprite.set_scale(Vector2(planet_radius * 2 / planet_texture.get_width(), planet_radius * 2 / planet_texture.get_height()))
	if shape:
		shape.set_radius(planet_radius)

func set_collision(enable):
	if enable and get_shape_count() == 0:
		add_shape(shape)
	elif !enable and get_shape_count() == 1:
		remove_shape(0)
		
func be_in_background(enable):
	set_collision(!enable)
	sprite.set_modulate(Color(1, 1, 1, 0.5))