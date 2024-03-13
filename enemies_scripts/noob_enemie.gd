class_name NoobEnemie extends BaseEnemie

var timer: Timer

func _init():
	pass
	
func _ready():
	hp = 500
	damage = 10
	speed = 10
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2
	timer.connect("timeout", hit_tower)
	timer.start()
	print(timer.time_left)
	print(timer.one_shot)
	print(timer.wait_time)
	print("timer_start")
	
	$health.max_value = hp
	$health.value = hp
	top_level = true
	$AnimatedSprite2D.play()
	killed.connect(on_kill)

func find_closest_tower(towers):
	var closest_distance = 10000
	var closest_tower = null
	#var tile_size = get_parent().texture_normal.get_size()
	var radius = 500 / 2 * 5
	for tower in towers.values():
		var distance = global_position.distance_to(tower.global_position)
		if closest_distance > distance and distance < radius:
			closest_distance = distance
			closest_tower = tower
	return closest_tower
	
#func find_enemy_and_fire():
	#var towers = get_parent().get_towers()
	#var tower = find_closest_tower(towers)
	#if tower == null:
		#return
	#var fireball = fireball_scene.instantiate()
	#fireball.init(
		#enemy, level_to_attack_power[current_level], global_position
	#)
	#get_parent().get_parent().add_child(fireball)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(timer.time_left)
	#print(get_children())
	var towers = get_parent().get_towers()
	#print(towers)
	var tower = find_closest_tower(towers)
	if tower == null:
		return
	else:
		var path_vector = (tower.global_position - global_position)
		if (path_vector.length() <= 50):
			return
		var delta_pos = path_vector.normalized() * speed * delta
		if path_vector.length() - 50 < delta_pos.length():
			delta_pos = path_vector - path_vector.normalized() * 50
		position = position + delta_pos
		
		#var distance = global_position.distance_to(tower.global_position)
		#if (distance > 50):
			#var x_velocity = (tower.global_position.x - global_position.x) / distance
			#var y_velocity = (tower.global_position.y - global_position.y) / distance
			#linear_velocity = Vector2(x_velocity * speed, y_velocity * speed)
			#print(distance)
		#else:
			#linear_velocity = Vector2(0, 0)
			

func hit_tower():
	print("Hit tower!")
	var towers = get_parent().get_towers()
	var tower = find_closest_tower(towers)
	var distance = global_position.distance_to(tower.global_position)
	if distance < 60:
		hit(tower, damage)

func hit(tower, damage):
	if (tower.hp > 0):
		tower.take_damage(damage)
#func _process(delta):
	#var path_vector = (target.global_position - global_position)
	#var delta_pos = path_vector.normalized() * speed * delta
	#if path_vector.length() < delta_pos.length():
		#delta_pos = path_vector
	#position = position + delta_pos
	#if (target.hp <= 0):
		#queue_free()
	#if (target.global_position - global_position).length() < 4:
		#target.take_damage(damage)
		#queue_free()
		
		
func take_damage(damage):
	hp -= damage
	$health.value = hp
	if (hp <= 0):
		killed.emit()
	hp_changed.emit(hp)

func on_kill():
	remove_child(timer)
	print("Dead!")
