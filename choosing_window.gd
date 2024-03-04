extends Panel
signal btn3
signal create
signal delete
#TODO: make it be screen size always

# Called when the node enters the scene tree for the first time.
func _ready():
	top_level = true
	$VBoxContainer/tower_list.hide()
	
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#anchors_preset = PRESET_RIGHT_WIDE
	#size.x = 200
	#position.x -= 200
	pass

func _on_create_pressed():
	print("Create click")
	create.emit()

func show_items(item_names):
	$VBoxContainer/tower_list.clear()
	print(40*len(item_names))
	$VBoxContainer/tower_list.size.y = 40*len(item_names)
	for item in item_names:
		$VBoxContainer/tower_list.add_item(item)
	$VBoxContainer/tower_list.show()

func _on_delete_pressed():
	delete.emit()
	


func _on_forest_tile_2_show_window():
	print('show vindow in window')
	show()


func _on_forest_tile_focus_exited():
	hide()

func _on_btn_3_pressed():
	btn3.emit()
	pass # Replace with function body.


func _on_hidden():
	$VBoxContainer/tower_list.clear()
