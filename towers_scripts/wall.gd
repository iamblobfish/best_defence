extends BaseTower

func _init():
	tower_type = TowerDescriptions.TowerType.WALL
	super._init()

func init():
	hp = 1000
	max_hp = 1000
	current_level = 0
