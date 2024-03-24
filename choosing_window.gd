extends Panel
signal upgrade
signal create
signal delete
#TODO: make it be screen size always

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#$margin/vbox/tower_list.hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_create_pressed():
	create.emit()

func add_item(tower, icon):
	$margin/vbox/tower_list.add_item(tower, icon)
	

func show_items():
	#$margin/vbox/tower_list.clear()
	#print(40*len($margin/vbox/tower_list.get_item_count()))
	$margin/vbox/tower_list.size.y = 40*$margin/vbox/tower_list.get_item_count()
	#$margin/vbox/tower_list.fixed_column_width = ($margin/vbox.size.x)/2 
	#for t in range($margin/vbox/tower_list.get_item_count()):
		#var img = $margin/vbox/tower_list.get_item_icon(t).get_image()
		#img.resize($margin/vbox.size.x/2-1, $margin/vbox.size.x/2-1)
		#$margin/vbox/tower_list.set_item_icon(t, img)
	$margin/vbox/tower_list.show()

func hide_items():
	$margin/vbox/tower_list.clear()
	$margin/vbox/tower_list


func _on_delete_pressed():
	delete.emit()

func _on_forest_tile_2_show_window():
	#print('show vindow in window')
	show()

func _on_forest_tile_focus_exited():
	hide()

func _on_upgrade_pressed():
	upgrade.emit()
