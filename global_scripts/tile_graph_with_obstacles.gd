extends Node

var aStar = AStar2D.new()
var tile_map
var tile_width
var tile_height
var adjustment
var state = 0

var tile_pos_to_id = {}
var id_to_tile_pos_with_adj = {}

func init(tiles, tile_w, tile_h):
	tile_map = tiles
	tile_width = tile_w
	tile_height = tile_h
	adjustment = Vector2(tile_width/2, tile_height/2)
	for tile_pos in tile_map:
		add_point(tile_pos)
	for tile_pos in tile_map:
		connect_tile(tile_pos)

func add_point(pos: Vector2):
	aStar.add_point(_generateID(pos), pos + adjustment)

func connect_tile(pos: Vector2):
	var neighbors = [
		Vector2(pos.x, pos.y + tile_height),
		Vector2(pos.x + tile_width * 3/4, pos.y + tile_height/2),
		Vector2(pos.x + tile_width * 3/4, pos.y - tile_height/2),
		Vector2(pos.x, pos.y - tile_height),
		Vector2(pos.x - tile_width * 3/4, pos.y - tile_height/2),
		Vector2(pos.x - tile_width * 3/4, pos.y + tile_height/2),
	]
	for neighbor_pos in neighbors:
		if tile_map.has(neighbor_pos):
			aStar.connect_points(tile_pos_to_id[pos], tile_pos_to_id[neighbor_pos])

func add_wall_obstacle(tower_pos):
	aStar.set_point_disabled(tile_pos_to_id[tower_pos])
	print(tower_pos + adjustment)
	state += 1

func remove_wall_obstacle(tower_pos):
	aStar.set_point_disabled(tile_pos_to_id[tower_pos], false)
	state += 1

func get_path_to_closest_tower(towers, enemy_pos):
	var closest_path = []
	var closest_distance = 1000
	for tower_pos in towers:
		if aStar.is_point_disabled(tile_pos_to_id[tower_pos]):
			continue
		var closest_point = aStar.get_closest_point(enemy_pos)
		var path = aStar.get_id_path(tile_pos_to_id[tower_pos], closest_point)
		if path.size() < closest_distance:
			closest_path = path
			closest_distance = path.size()
	var result_closest_path = []
	for path_id in closest_path:
		result_closest_path.append(id_to_tile_pos_with_adj[path_id])
	print(result_closest_path)
	return result_closest_path

func _generateID(pos):
	var id = aStar.get_available_point_id()
	id_to_tile_pos_with_adj[id] = pos + adjustment
	tile_pos_to_id[pos] = id
	return id
