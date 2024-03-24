extends BaseTower

var level_to_currency_per_wave = {
	1: 15,
	2: 25,
	3: 35,
	4: 45
}

func _init():
	tower_type = TowerDescriptions.TowerType.MINING
	super._init()

func init():
	hp = 50
	max_hp = 50
	current_level = 0

func on_wave_end():
	# TODO: UI effect for + money
	PlayerState.add_currency(level_to_currency_per_wave[current_level])
