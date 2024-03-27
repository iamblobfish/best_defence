class_name BaseEnemie
extends AnimatedSprite2D

signal killed

var hp: int = 0
var damage: int = 0
var damage_speed: int = 0
var damage_distance: int = 0
var speed: int = 0
var gain: int = 0
var self_scale:float = 1


var attack_timer: Timer

var wall_obstacles_state = null
var path = null

func _init():
	pass
	
func _ready():
	scale = Vector2(0.7, 0.7)*self_scale
	setup_attack_timer()
	$health.max_value = hp
	$health.value = hp
	top_level = true
	play()
	

func setup_attack_timer():
	attack_timer = Timer.new()
	add_child(attack_timer)
	attack_timer.wait_time = damage_speed
	attack_timer.connect("timeout", hit_tower)
	attack_timer.start()

func movement_with_obstacles(delta):
	var towers_coord_to_state_map = get_parent().get_towers_coord_to_state_map()
	
	if TileGraphWithObstacles.state != wall_obstacles_state:
		wall_obstacles_state = TileGraphWithObstacles.state
		path = TileGraphWithObstacles.get_path_to_closest_tower(
			towers_coord_to_state_map,
			position
		)
	
	if path.size() == 0:
		regular_movement(delta)
		return
	
	var next_point = path[-1]
	var path_vector = (next_point - position)
	
	if (path_vector.length() <= 30 and path.size() <= 1):
		animation = "stay"
		return
	else:
		animation = "walk"
		flip_h = path_vector.x < 0
	var delta_pos = path_vector.normalized() * speed * delta
	if path_vector.length() - 30 < delta_pos.length() and path.size() <= 1:
		delta_pos = path_vector - path_vector.normalized() * 30
		position = position + delta_pos
		return
	if path_vector.length() < delta_pos.length():
		path.pop_back()
		movement_with_obstacles(delta)
		return
	position = position + delta_pos
	

func find_closest_tower():
	var towers_coord_to_state_map = get_parent().get_towers_coord_to_state_map()
	var closest_distance = 100000
	var closest_tower = null
	var radius = 500 / 2 * 5
	for tower_state in towers_coord_to_state_map.values():
		var tower = tower_state.tower_ref
		var distance = global_position.distance_to(tower.global_position)
		if closest_distance > distance and distance < radius:
			closest_distance = distance
			closest_tower = tower
	return closest_tower

func regular_movement(delta):
	var tower = find_closest_tower()
	if tower == null:
		animation = "stay"
		return
	var path_vector = (tower.global_position - global_position)
	var delta_pos = path_vector.normalized() * speed * delta
	if (path_vector.length() <= damage_distance):
		animation = "stay"
		return
	else:
		animation = "walk"
		flip_h = path_vector.x < 0
	# if step is too much when go until damage distance
	if path_vector.length() - damage_distance < delta_pos.length():
		delta_pos = path_vector - path_vector.normalized() * damage_distance
	position = position + delta_pos

func _process(delta):
	movement_with_obstacles(delta)

func hit_tower():
	var tower = find_closest_tower()
	if tower:
		var distance = global_position.distance_to(tower.global_position)
		if distance <= damage_distance + 1:
			tower.take_damage(damage)
		
func take_damage(damage):
	hp -= damage
	if (hp <= 0):
		hp = 0
		killed.emit()
		PlayerState.add_currency(gain)
		remove_child(attack_timer)
	$health.value = hp

