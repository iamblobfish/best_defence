extends Panel
signal btn3
signal create
signal delete


# Called when the node enters the scene tree for the first time.
func _ready():
	create.connect(_on_create_pressed)
	delete.connect(_on_delete_pressed)
	btn3.connect(_on_btn3_pressed)
	#anchors_preset = PRESET_RIGHT_WIDE
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_create_pressed():
	print("Create click")
	create.emit()


func _on_delete_pressed():
	delete.emit()

func _on_btn3_pressed():
	btn3.emit()

func _on_visibility_changed():
	print('fuck')


func _on_forest_tile_2_show_window():
	print('show vindow in window')
	show()


func _on_forest_tile_focus_exited():
	hide()

