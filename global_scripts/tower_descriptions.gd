#class_name  TowerDescriptions
extends Node

enum TowerType {
	ATTACK_BASE,
	MINING
}


var towers_create_images = {
	TowerType.MINING:"res://tiles/castles/castle1.png" ,
	TowerType.ATTACK_BASE: "res://tiles/castles/castle3.png"
}

var towers_create_costs = {
	TowerType.MINING: 30,
	TowerType.ATTACK_BASE: 20
}
