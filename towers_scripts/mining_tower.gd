extends BaseTower

var level_to_currency_per_wave = {
	1: 15,
	2: 25,
	3: 35,
	4: 45
}

func init():
	hp = 50
	max_hp = 50
	tower_type = TowerType.MINING
	current_level = 0
	maximum_level = 2
	level_to_destroy_gain = {
		1: 25,
		2: 40,
		3: 50,
		4: 60
	}
	level_to_upgrade_cost = {
		1: 30,
		2: 30,
		3: 40
	}
	level_to_texture_dict = {
		1: "res://tiles/castles/castle1.png",
		2: "res://tiles/castles/castle2.png"
	}

func on_wave_end():
	# TODO: UI effect for + money
	PlayerState.add_currency(level_to_currency_per_wave[current_level])
