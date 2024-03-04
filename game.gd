extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Window.create.connect(_on_window_create)
	#$Window.delete.connect(_on_window_delete)
	#$Window.btn3.connect(_on_window_btn3)
	#$background.position = Vector2(-$background.size.x/4, -$background.size.y/4)
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


# signals sent from map to window
func window_update():
	print('focused tile: ', $map.focused_tile)
	var tower_state =  $map.focused_tile.get_tower_state()
	print(tower_state)
	$Window/VBoxContainer/btn3.hide()
	$Window/VBoxContainer/Create.hide()
	$Window/VBoxContainer/delete.hide()
	if not tower_state.is_build:
		$Window/VBoxContainer/Create.show()
		$Window.show_items(['Attack tower', "Mining tower"])
	else:
		$Window/VBoxContainer/delete.show()
		if tower_state.is_upgradable:
			$Window/VBoxContainer/btn3.show()
	$Window.show()
	print($Camera2D.zoom, $Camera2D.offset)

func _on_map_window_hide():
	$Window.hide()
	
# signals sent from window to map

func _on_window_create_or_update():
	if $map.focused_tile:
		$map.focused_tile.create_tower()
	window_update()

func _on_window_delete():
	if $map.focused_tile:
		$map.focused_tile.delete_tower()
	window_update()


func _on_camera_2d_move():
	print('move')
	
	print($Window.position)
	print(get_global_transform_with_canvas())
	print($Camera2D.zoom)
	$Window.position.x *= $Camera2D.zoom.x
	#$Window.position+=get_global_transform_with_canvas()[2]
	#$Window.size+=get_global_transform_with_canvas()[2]
	#print($Window.position)
	#$Window.anchors_preset = PRESET_RIGHT_WIDE
	#$Window.size.x = 200
	#$Window.position.x -= 200
	pass
