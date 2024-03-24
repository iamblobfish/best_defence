extends BaseAttackTower

func assign_type():
	tower_type = TowerDescriptions.TowerType.ATTACK_DESTROYER

var latest_attacked_enemie = null
var damage_scale = 1

func on_enemie_died():
	latest_attacked_enemie = null
	damage_scale = 1

func find_enemy_and_fire():
	var enemy
	if latest_attacked_enemie == null:
		var enemies = get_parent().get_enemies()
		enemy = find_closest_enemy(enemies)
		if enemy != null:
			enemy.killed.connect(on_enemie_died)
		latest_attacked_enemie = enemy
	else:
		enemy = latest_attacked_enemie
	
	if enemy == null:
		return
	
	var fireball = fireball_scene.instantiate()
	fireball.init(
		enemy, level_to_attack_power[current_level], global_position
	)
	fireball.damage *= damage_scale
	fireball.scale *= 1 + log(damage_scale)
	damage_scale = damage_scale * 1.25
	get_parent().get_parent().add_child(fireball)
