extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Window.create.connect(_on_window_create)
	#$Window.delete.connect(_on_window_delete)
	#$Window.btn3.connect(_on_window_btn3)
	#$background.position = Vector2(-$background.size.x/4, -$background.size.y/4)
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var window = $Window/margin/vbox

var TowerType = TowerDescriptions.TowerType
# signals sent from map to window
func window_update():
	print('focused tile: ', $map.focused_tile)
	var tower_state =  $map.focused_tile.get_tower_state()
	
	for i in window.get_children():
		i.hide()
	if not tower_state.is_build:
		window.get_child(1).show()
		window.get_child(0).clear()
		for type in range(len(TowerType)):
			var img = Image.load_from_file(TowerDescriptions.towers_create_images[type])
			img.resize(120, 120)
			$Window.add_item("Cost: "+str(TowerDescriptions.towers_create_costs[type]), ImageTexture.create_from_image(img))
		$Window.show_items()
	else:
		window.get_child(2).show()
		if tower_state.is_upgradable:
			window.get_child(3).show()
	$Window.show()
	print($Camera2D.zoom, $Camera2D.offset)
	#print(window.get_child(2).text)
	window.get_child(4).pressed.connect(on_add_butt_click)
	window.get_child(4).text = "Damage"
	window.get_child(4).show()
	

func on_add_butt_click():
	if $map.focused_tile:
		$map.focused_tile.damage_tower(10)
	pass

func _on_map_window_hide():
	for i in window.get_children():
		i.hide()
	$Window.hide()

# signals sent from window to map

func _on_window_create_or_update():
	if window.get_child(0).visible and not window.get_child(0).is_anything_selected():
		$ok.dialog_text = "Select tower type!"
		$ok.position.y -= 100
		$ok.show()
	else:
		var tower_type = window.get_child(0).get_selected_items()[0]
		print("tower type: ", tower_type)
		if $map.focused_tile:
			$map.focused_tile.create_tower(tower_type)
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


