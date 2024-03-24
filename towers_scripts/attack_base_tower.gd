extends BaseTower

var fireball_scene = preload("res://fireball.tscn")
var timer: Timer

func _init():
	tower_type = TowerDescriptions.TowerType.ATTACK_BASE
	super._init()

var level_to_attack_power = {
	1: 10,
	2: 15,
	3: 20
}

func init():
	hp = 150
	max_hp = 150
	current_level = 0
	
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.connect("timeout", find_enemy_and_fire)
	timer.start()

func find_closest_enemy(enemies):
	var closest_distance = 10000
	var closest_enemy = null
	var tile_size = get_parent().texture_normal.get_size()
	var radius = tile_size.y / 2 * 5
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if closest_distance > distance and distance < radius:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy

func find_enemy_and_fire():
	var enemies = get_parent().get_enemies()
	var enemy = find_closest_enemy(enemies)
	if enemy == null:
		return
	var fireball = fireball_scene.instantiate()
	fireball.init(
		enemy, level_to_attack_power[current_level], global_position
	)
	get_parent().get_parent().add_child(fireball)

func destroy():
	remove_child(timer)
	super.destroy()
	
