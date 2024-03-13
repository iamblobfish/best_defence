extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	#print($ForestTile2.position)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_forest_tile_2_show_window():
	#print('entered')
	#var t = $ForestTile2/Tower.get_tower()
	#$Window/VBoxContainer/btn3.hide()
	#$Window/VBoxContainer/Create.hide()
	#$Window/VBoxContainer/delete.hide()
	#if t==-1:
		#$Window/VBoxContainer/Create.show()
	#else:
		#$Window/VBoxContainer/delete.show()
		#if $ForestTile2/Tower.updatable():
			#$Window/VBoxContainer/btn3.show()
	#$Window.show()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = local_to_map(to_local(global_clicked))
			#var children = get_chi
			#print("data: ", data)
			
			#print($ForestTile2.show_window.get_connections())




func _on_forest_tile_2_tile_focus_entered():
	
	#print('entered')
	var t = $ForestTile2/Tower.get_tower()
	$Window/VBoxContainer/btn3.hide()
	$Window/VBoxContainer/Create.hide()
	$Window/VBoxContainer/delete.hide()
	if t==-1:
		$Window/VBoxContainer/Create.show()
	else:
		$Window/VBoxContainer/delete.show()
		if $ForestTile2/Tower.updatable():
			$Window/VBoxContainer/btn3.show()
	$Window.show()
	#pass # Replace with function body.

#
#func _on_forest_tile_2_show_window():
	#print('entered')
	##var t = $ForestTile2/Tower.get_tower()
	##$Window/VBoxContainer/btn3.hide()
	##$Window/VBoxContainer/Create.hide()
	##$Window/VBoxContainer/delete.hide()
	##if t==-1:
		##$Window/VBoxContainer/Create.show()
	##else:
		##$Window/VBoxContainer/delete.show()
		##if $ForestTile2/Tower.updatable():
			##$Window/VBoxContainer/btn3.show()
	##$Window.show()


func _on_forest_tile_2_pressed():
	#print('pressed')

