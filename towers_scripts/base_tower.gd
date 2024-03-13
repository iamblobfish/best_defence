class_name BaseTower 
extends Sprite2D

signal on_tower_destroyed

var parent: Node2D = null

var max_hp: int = 0
var hp: int = 1000
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
	pass
	# TODO: tile specifications

func create_or_update():
	if current_level >= maximum_level:
		return
	current_level += 1
	
	if current_level == 1:
		PlayerState.reduce_currency(towers_cost[tower_type])
	else:
		PlayerState.reduce_currency(level_to_upgrade_cost[current_level-1])
	
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

func destroy():
	# TODO: curent_level set to 0? 
	# TODO: add destoroy value to overall money
	texture = null
	current_level = 0
	tower_type = TowerType.NOTHING
	on_tower_destroyed.emit()
	hide()

func get_state():
	var tower_state = TowerState.new()
	tower_state.is_build = tower_type != TowerType.NOTHING
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
	

func get_damage(damage_size):
	if hp - damage_size <= 0:
		# TODO: is it true? 
		hp = 0
		$health.value = hp
		destroy()
	else: 
		hp -= damage_size
		$health.value = hp
	print(hp)
	

	
	
	
