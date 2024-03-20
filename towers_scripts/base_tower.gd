class_name BaseTower 
extends Sprite2D

signal on_tower_destroyed
signal not_enough_money

var max_hp: int = 0
var hp: int = 0
var current_level: int = 0
var maximum_level: int = 0
var tower_type: TowerType = TowerType.NOTHING

var level_to_destroy_gain: Dictionary
var level_to_upgrade_cost: Dictionary
var level_to_texture_dict: Dictionary

enum TowerType {
	NOTHING,
	MINING,
	ATTACK_BASE
}

var towers_cost = {
	TowerType.NOTHING: 0,
	TowerType.MINING: 30,
	TowerType.ATTACK_BASE: 20
}

func _init():
	texture = null
	pass
	# TODO: tile specifications

func create_or_update():
	init()
	if current_level >= maximum_level:
		return
	current_level += 1
	
	if current_level == 1:
		if not PlayerState.reduce_currency(towers_cost[tower_type]):
			current_level -= 1
			return -1
	else:
		if not PlayerState.reduce_currency(level_to_upgrade_cost[current_level-1]):
			current_level -= 1
			return -1
	
	texture = ImageTexture.create_from_image(
		Image.load_from_file(level_to_texture_dict[current_level])
	)
	# progress bar part
	$health.max_value = max_hp
	$health.value = hp
	# ------
	if hidden:
		show()
		$health.show()

func init():
	return

func destroy():
	texture = null
	current_level = 0
	tower_type = TowerType.NOTHING
	print(tower_type)
	hide()
	
func disassemble():
	PlayerState.add_currency(level_to_destroy_gain[current_level])
	texture = null
	current_level = 0
	tower_type = TowerType.NOTHING
	print(tower_type)

func get_state():
	var tower_state = TowerState.new()
	tower_state.is_build = (tower_type != TowerType.NOTHING)
	if not tower_state.is_build:
		return tower_state
	tower_state.tower_type = tower_type
	tower_state.is_damaged = hp < max_hp
	tower_state.is_upgradable = current_level < maximum_level
	var repair_cost = towers_cost[tower_type]
	for i in range(1, current_level+1):
		repair_cost += level_to_upgrade_cost[i]
	tower_state.repair_cost = repair_cost * (max_hp - hp) / max_hp
	tower_state.destroy_gain = level_to_destroy_gain[current_level]
	tower_state.upgrade_cost = level_to_upgrade_cost[current_level]
	tower_state.tower_ref = self
	return tower_state
  

class TowerState:
	var is_build: bool
	var tower_type: TowerType
	var is_upgradable: bool
	var upgrade_cost: int
	var is_damaged: bool
	var repair_cost: int
	var destroy_gain: int
	var tower_ref: Node
	
	func _to_string():
		print("is_build: ", is_build, "\ntower_type: ", tower_type, "\nis_upgradable: ", is_upgradable, "\nupgrade_cost: ", upgrade_cost,  "\nis_damaged: ", is_damaged, "\nrepair_cost: ", repair_cost, "\ndestroy_gain: ", destroy_gain)
	

func get_costs_list():
	return {'Mining': towers_cost[TowerType.MINING], "Attack": towers_cost[TowerType.ATTACK_BASE]}
	

func make_damage(damage):
	if hp - damage <= 0:
		hp = 0
		destroy()
	else: 
		hp -= damage
		$health.value = hp
	#print(hp)
	

