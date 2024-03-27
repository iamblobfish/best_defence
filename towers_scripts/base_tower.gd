class_name BaseTower 
extends Sprite2D

signal on_tower_destroyed
signal not_enough_money

var max_hp: int = 0
var hp: int = 0
var current_level: int = 0
var maximum_level: int = 0
var tower_type: TowerDescriptions.TowerType = TowerDescriptions.TowerType.NOTHING
var tower_cost: int = 0

var level_to_destroy_gain: Dictionary
var level_to_upgrade_cost: Dictionary
var level_to_texture: Dictionary
var successors: Array

var tower_description

func _init():
	texture = null
	tower_description = TowerDescriptions.get_description(tower_type)
	level_to_destroy_gain = TowerDescriptions.string_keys_to_int_keys(
		tower_description["level_to_destroy_gain"]
	)
	level_to_upgrade_cost = TowerDescriptions.string_keys_to_int_keys(
		tower_description["level_to_upgrade_cost"]
	)
	level_to_texture = TowerDescriptions.string_keys_to_int_keys(
		tower_description["level_to_texture"]
	)
	maximum_level = tower_description["maximum_level"]
	tower_cost = int(tower_description["cost"])
	successors = tower_description["succsessors"]
	pass
	# TODO: tile specifications

func create_or_upgrade():
	if current_level >= maximum_level:
		return -2
	
	current_level += 1
	
	if current_level == 1:
		if not PlayerState.reduce_currency(tower_cost):
			current_level -= 1
			return -1
		init()
	else:
		if not PlayerState.reduce_currency(level_to_upgrade_cost[current_level-1]):
			current_level -= 1
			return -1
		upgrade()
	texture = ImageTexture.create_from_image(
		Image.load_from_file(level_to_texture[current_level])
	)
	
	# progress bar part
	$health.position.y = -100
	$health.max_value = max_hp
	$health.value = hp
	# ------
	if hidden:
		show()
		$health.show()

func init():
	TileGraphWithObstacles.state += 1
	return

func upgrade():
	return

func destroy():
	TileGraphWithObstacles.state += 1
	texture = null
	current_level = 0
	current_level = 0
	tower_type = TowerDescriptions.TowerType.NOTHING
	hide()
	on_tower_destroyed.emit()

func disassemble():
	PlayerState.add_currency(level_to_destroy_gain[current_level])
	destroy()

func get_state():
	var tower_state = TowerDescriptions.TowerState.new()
	tower_state.is_selection_available = tower_type == TowerDescriptions.TowerType.NOTHING \
		or (current_level == maximum_level and successors.size() > 0)
	tower_state.successors_info = get_successors_info()
	if tower_type == TowerDescriptions.TowerType.NOTHING:
		return tower_state
	tower_state.tower_type = tower_type
	tower_state.is_damaged = hp < max_hp
	tower_state.is_upgradable = current_level < maximum_level
	#var repair_cost = towers_cost[tower_type]
	#for i in range(1, current_level):
		#repair_cost += level_to_upgrade_cost[i]
	#tower_state.repair_cost = repair_cost * (max_hp - hp) / max_hp
	tower_state.destroy_gain = level_to_destroy_gain[current_level]
	if current_level < maximum_level:
		tower_state.upgrade_cost = level_to_upgrade_cost[current_level]
	tower_state.tower_ref = self
	return tower_state

func get_successors_info():
	var successors_array = []
	for successor_tower_type in successors:
		successors_array.append(TowerDescriptions.get_successor_info(int(successor_tower_type)))
	return successors_array

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		hp = 0
		destroy()
		return
	$health.value = hp

