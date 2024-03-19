class_name BaseEnemie
extends AnimatedSprite2D

signal killed

var hp: int = 0
var damage: int = 0
var damage_speed: int = 0
var damage_distance: int = 0
var speed: int = 0

var timer: Timer

func _init():
	pass
	
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = damage_speed
	timer.connect("timeout", hit_tower)
	timer.start()
	$health.max_value = hp
	$health.value = hp
	top_level = true
	play()

func find_closest_tower():
	var towers = get_parent().get_towers()
	var closest_distance = 100000
	var closest_tower = null
	var radius = 500 / 2 * 5
	for tower in towers.values():
		var distance = global_position.distance_to(tower.global_position)
		if closest_distance > distance and distance < radius:
			closest_distance = distance
			closest_tower = tower
	return closest_tower


func _process(delta):
	var tower = find_closest_tower()
	if tower == null:
		return
	else:
		var path_vector = (tower.global_position - global_position)
		var delta_pos = path_vector.normalized() * speed * delta
		if (path_vector.length() <= damage_distance):
			return
		if path_vector.length() - damage_distance+1 < delta_pos.length():
			delta_pos = path_vector - path_vector.normalized() * damage_distance
		position = position + delta_pos
		
		
			

func hit_tower():
	var tower = find_closest_tower()
	if tower:
		var distance = global_position.distance_to(tower.global_position)
		if distance <= damage_distance:
			tower.make_damage(damage)
		
		
func make_damage(damage):
	hp -= damage
	if (hp <= 0):
		hp = 0
		killed.emit()
		remove_child(timer)
	$health.value = hp

