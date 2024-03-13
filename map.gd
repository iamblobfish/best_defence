extends Node2D
signal window_hide
signal window_update
var tile_map = {}
var focused_tile = null
var margin = Vector2(100, 100)
var enemies = {}
var tile_width = 128
var tile_height = 66
var tiles_in_column = 5
var tiles_in_row = 8

# Called when the node enters the scene tree for the firrst time.
func _ready():
	var scene = preload('res://tile.tscn')
	var enemie_scene = preload("res://enemy.tscn")
	
	for i in range(tiles_in_column * 2):
		for j in range(tiles_in_row / 2):
			var tile = scene.instantiate()
			if i%2==0:
				tile.position = margin + Vector2(j*tile_width*3/2, tile_height*i/2)
			else:
				tile.position = margin + Vector2(tile_width*3/4+j*tile_width*3/2, tile_height*i/2)
			tile_map[tile.position] = tile
			tile.tile_focused.connect(on_tile_focused.bind(tile))
			tile.tile_unfocused.connect(on_tile_unfocused.bind(tile))
			tile.tower_update.connect(on_tower_update.bind(tile))
			add_child(tile)

func get_towers():
	var towers = {}
	for tile_position in tile_map:
		var tower_state = tile_map[tile_position].get_tower_state()
		if tower_state.is_build:
			towers[tile_position] = tower_state.tower_ref
	print(towers)
	return towers

func generate_wave():
	var dict_of_enemies = { 1: 10 }
	var dict_of_enemies_scenes = { 1: preload("res://enemy.tscn") }
	for type in dict_of_enemies:
		for count in dict_of_enemies[type]:
			var enemie = dict_of_enemies_scenes[type].instantiate()
			enemie.position = find_perfect_spawn_place()
			enemies[enemie] = null
			enemie.killed.connect(on_enemy_died.bind(enemie))
			add_child(enemie)

func find_random_coordinates_on_field():
	var rng = RandomNumberGenerator.new()
	var field_height = tile_height * (tiles_in_column + 1/2)
	var field_width = tile_width * 3/2 * (tiles_in_row / 2)
	var y = rng.randf_range(0, field_height)
	var x = rng.randf_range(0, field_width)
	return Vector2(x, y) + margin

func is_enemy_near_tower(towers_pos, enemy_pos):
	for tower_pos in towers_pos:
		var delta = tower_pos - enemy_pos
		# normalisation
		delta.y = delta.y * tile_width / tile_height
		if delta.length() < tile_width * 1.5:
			return true
	return false

func find_perfect_spawn_place():
	var spawn_coord = find_random_coordinates_on_field()
	while is_enemy_near_tower(get_towers().keys(), spawn_coord):
		spawn_coord = find_random_coordinates_on_field()
	return spawn_coord

func on_enemy_died(enemy):
	remove_child(enemy)
	enemies.erase(enemy)

func on_tile_focused(tile):
	focused_tile = tile
	if get_towers().size() == 5:
		generate_wave()
	window_update.emit()

func on_tile_unfocused(tile):
	focused_tile = null
	window_hide.emit()
	
func on_tower_update(tile):
	window_update.emit()
