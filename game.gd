extends Control

@onready var money = $money_bar/container/amount

# Called when the node enters the scene tree for the first time.
func _ready():
	money.text = str(PlayerState.currency)
	# PlayerState.out_of_money.connect(game_over)
	pass # Replace with function body.

func _process(delta):
	money.text = str(PlayerState.currency)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var window = $Window/margin/vbox

var TowerType = TowerDescriptions.TowerType
var options_tower_type_list
# signals sent from map to window
func window_update():
	var tower_state = $map.focused_tile.get_tower_state()
	for i in window.get_children():
		i.hide()
	if tower_state.is_selection_available:
		window.get_child(1).show()
		window.get_child(0).clear()
		options_tower_type_list = []
		for successor_info in tower_state.successors_info:
			var img = Image.load_from_file(successor_info.image)
			img.resize(120, 120)
			options_tower_type_list.append(successor_info.tower_type)
			$Window.add_item(
				"Cost: "+str(successor_info.cost), 
				ImageTexture.create_from_image(img)
			)
		
		$Window.show_items()
	else:
		window.get_child(2).show()
		if tower_state.is_upgradable:
			window.get_child(3).show()
	$Window.show()
	print($Camera2D.zoom, $Camera2D.offset)


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
		var choise_index = window.get_child(0).get_selected_items()[0]
		if $map.focused_tile:
			if $map.focused_tile.create_tower(options_tower_type_list[choise_index]) == -1:
				$ok.dialog_text = "Not enough money!"
				$ok.position.y -= 100
				$ok.show()
		window_update()

func _on_window_delete():
	if $map.focused_tile:
		$map.focused_tile.delete_tower()
	window_update() 

func _on_window_upgrade():
	if $map.focused_tile:
		$map.focused_tile.upgrade_tower()
	window_update()

func _on_camera_2d_move():
	#print('move')
	
	#print($Window.position)
	#print(get_global_transform_with_canvas())
	#print($Camera2D.zoom)
	$Window.position.x *= $Camera2D.zoom.x
	#$Window.position+=get_global_transform_with_canvas()[2]
	#$Window.size+=get_global_transform_with_canvas()[2]
	#print($Window.position)
	#$Window.anchors_preset = PRESET_RIGHT_WIDE
	#$Window.size.x = 200
	#$Window.position.x -= 200
	pass

func game_over():
	$big_text/Label.text = "Game over"
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 5
	timer.connect("timeout", homecomming.bind(timer))
	$big_text.show()
	timer.start()
	
	
func homecomming(timer):
	$big_text.hide()
	remove_child(timer)
	get_tree().change_scene_to_file("res://Home.tscn")

func set_wave_timeout(time: int):
	$WaveInfoContainer/WaveTimeout.text = "Next wave in " + str(time)

func set_wave_number(num: int):
	$WaveInfoContainer/WaveNumber.text = "Current wave " + str(num)
