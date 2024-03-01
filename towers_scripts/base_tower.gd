class_name BaseTower 
extends Sprite2D

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
	pass
	# TODO: tile specifications

func create_or_update():
	# TODO: substract money
	if current_level >= maximum_level:
		return
	current_level += 1
	texture = ImageTexture.create_from_image(
		Image.load_from_file(level_to_texture_dict[current_level])
	)
	if hidden:
		show()

func destroy():
	# TODO: add destoroy value to overall money
	texture = null
	hide()

func get_state():
	var tower_state = TowerState.new()
	tower_state.is_build = tower_type != TowerType.NOTHING
	tower_state.tower_type = tower_type
	tower_state.is_damaged = hp < max_hp
	tower_state.is_upgradable = current_level < maximum_level
	var repair_cost = towers_cost[tower_type]
	for i in range(1, current_level+1):
		repair_cost += level_to_upgrade_cost[i]
	tower_state.repair_cost = repair_cost * (max_hp - hp) / max_hp
	tower_state.destroy_gain = level_to_destroy_gain[current_level]
	tower_state.upgrade_cost = level_to_upgrade_cost[current_level]
	return tower_state
	

class TowerState:
	var is_build: bool
	var tower_type: TowerType
	var is_upgradable: bool
	var upgrade_cost: int
	var is_damaged: bool
	var repair_cost: int
	var destroy_gain: int


