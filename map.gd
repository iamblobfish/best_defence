extends Node2D
signal window_hide
signal window_update
var tile_map = {}
var focused_tile = null
var margin = Vector2(100, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = preload('res://forest_tile.tscn')
	
	for i in range(10):
		for j in range(4):
			var tile = scene.instantiate()
			if i%2==0:
				tile.position = margin+Vector2(j*130*3/2, 85*i/2)
			else:
				tile.position = margin+Vector2(65*3/2+j*130*3/2, 85*i/2)
			tile_map[tile.position] = tile
			tile.tile_focused.connect(on_tile_focused.bind(tile))
			tile.tile_unfocused.connect(on_tile_unfocused.bind(tile))
			add_child(tile)

func on_tile_focused(tile):
	focused_tile = tile
	window_update.emit()

func on_tile_unfocused(tile):
	focused_tile = null
	window_hide.emit()
