extends BaseTower

var timer: Timer

var level_to_attack_power = {
	1: 10,
	2: 15,
	3: 20
}

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
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.connect("timeout", find_enemy_end_fire)
	timer.start()
	print(get_child_count())

func find_enemy_end_fire():
	print("Fire!")
	var enemy = null
	if enemy == null:
		return

func destroy():
	remove_child(timer)
	super.destroy()
