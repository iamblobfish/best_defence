extends BaseTower

func _init():
	tower_type = TowerDescriptions.TowerType.WALL
	super._init()

func init():
	super.init()
	hp = 200
	max_hp = 200
	TileGraphWithObstacles.add_wall_obstacle(get_parent().position)

func destroy():
	TileGraphWithObstacles.remove_wall_obstacle(get_parent().position)
	super.destroy()
