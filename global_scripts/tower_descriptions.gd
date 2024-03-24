#class_name  TowerDescriptions
extends Node

enum TowerType {
	NOTHING,
	ATTACK_BASE,
	MINING,
	WALL,
}

class TowerState:
	var is_build: bool
	var tower_type: TowerDescriptions.TowerType
	var is_upgradable: bool
	var upgrade_cost: int
	var is_damaged: bool
	var repair_cost: int
	var destroy_gain: int
	var successors_info: Array
	var tower_ref: Node
	
	func _to_string():
		print("is_build: ", is_build, "\ntower_type: ", tower_type, "\nis_upgradable: ", is_upgradable, "\nupgrade_cost: ", upgrade_cost,  "\nis_damaged: ", is_damaged, "\nrepair_cost: ", repair_cost, "\ndestroy_gain: ", destroy_gain)

class TowerSuccessorInfo:
	var name: String
	var cost: int
	var image

var towers_create_images = {
	TowerType.MINING:"res://tiles/castles/castle1.png" ,
	TowerType.ATTACK_BASE: "res://tiles/castles/castle3.png",
	TowerType.WALL: "res://tiles/castles/mountain.png",
}

var towers_create_costs = {
	TowerType.MINING: 30,
	TowerType.ATTACK_BASE: 20,
	TowerType.WALL: 20,
}

var loaded_descriptions = {}

var tower_type_to_descr_location = {
	TowerType.NOTHING: "res://towers_descriptions/base_tower.json",
	TowerType.ATTACK_BASE: "res://towers_descriptions/base_attack_tower.json",
	TowerType.MINING: "res://towers_descriptions/mining_tower.json",
	TowerType.WALL: "res://towers_descriptions/wall.json"
}

func get_description(tower_type: TowerType):
	if loaded_descriptions.has(tower_type):
		return loaded_descriptions[tower_type]
	var location = tower_type_to_descr_location[tower_type]
	var json_string = FileAccess.get_file_as_string(location)
	var description = JSON.parse_string(json_string)
	loaded_descriptions[tower_type] = description
	return description

func get_successor_info(tower_type):
	var descritpor = TowerDescriptions.get_description(tower_type)
	var successor_info = TowerDescriptions.TowerSuccessorInfo.new()
	successor_info.name = descritpor["name"]
	successor_info.cost = descritpor["cost"]
	successor_info.image = descritpor["level_to_texture"]["1"]
	return successor_info

func string_keys_to_int_keys(dictionary):
	var result = {}
	for key in dictionary:
		result[int(key)] = dictionary[key]
	return result
