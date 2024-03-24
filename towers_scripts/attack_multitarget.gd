extends BaseAttackTower

func assign_type():
	tower_type = TowerDescriptions.TowerType.ATTACK_MULTITARGET

func find_enemy_and_fire():
	var enemies = get_parent().get_enemies()
	for i in range(current_level + 3):
		var enemy = find_closest_enemy(enemies)
		if enemy == null:
			return
		var fireball = fireball_scene.instantiate()
		fireball.init(
			enemy, level_to_attack_power[current_level], global_position
		)
		get_parent().get_parent().add_child(fireball)
		enemies.erase(enemy)
