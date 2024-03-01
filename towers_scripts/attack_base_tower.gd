extends BaseTower

func _init():
	hp = 150
	max_hp = 150
	tower_type = TowerType.ATTACK_BASE
	current_level = 0
	maximum_level = 1
	level_to_destroy_gain = {
		1: 10,
		2: 20,
		3: 30,
		4: 40
	}
	level_to_upgrade_cost = {
		1: 20,
		2: 30,
		3: 40
	}
	level_to_texture_dict = {
		1: "res://tiles/castles/castle3.png"
	}
