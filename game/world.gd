extends Node2D

var levels = {
	"level0" : null,
	"level1" : null,
	"level2" : null
}
var levels_order = ["level0", "level1", "level2"]
var levels_index = 0

var player = null

func _ready():
	player = get_node("player")

	for level_name in levels:
		var level = load("levels/"+level_name+".tscn")
		levels[level_name] = level.instance()
		add_child(levels[level_name])
	
	set_level(levels_order[0])
	set_fixed_process(true)

func _fixed_process(delta):
	var level = levels[levels_order[levels_index]]
	for gate in level.get_node("gates").get_children():
		if player.get_node("shape").get_shape().collide(player.get_transform(), gate.get_node("shape").get_shape(), gate.get_transform()):
			set_level(gate.level_name)

func update_level_index(level_name):
	levels_index = 0
	for level in levels_order:
		if level == level_name:
			break
		levels_index = levels_index + 1

func set_level(level_name):
	update_level_index(level_name)

	var i = 0
	for level in levels_order:
		var level_i = levels[level]
		if i < levels_index:
			remove_child(level_i)
		elif i == levels_index:
			level_i.set_scale(Vector2(1, 1))
			var planet = level_i.get_node("planet")
			planet.be_in_background(false)
			player.gravity = planet.get_pos()
		else:
			pass
			level_i.set_scale(Vector2(1, 1) * 0.5)
		
		i = i + 1
