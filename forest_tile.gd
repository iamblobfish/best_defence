extends TextureButton
signal tile_focused
signal tile_unfocused
# Called when the node enters the scene tree for the first time.

var focus = false
func _ready():
	forest()
	pass # Replace with function body.
	
func forest():
	texture_normal = ImageTexture.create_from_image(Image.load_from_file("res://tiles/forest_new.png"))
	texture_hover = ImageTexture.create_from_image(Image.load_from_file("res://tiles/shiny_forest_new.png"))
	texture_focused = ImageTexture.create_from_image(Image.load_from_file("res://tiles/shiny_forest_new.png"))


func base():
	texture_normal = ImageTexture.create_from_image(Image.load_from_file("res://tiles/base.png"))
	texture_hover = ImageTexture.create_from_image(Image.load_from_file("res://tiles/base_shiny.png"))
	texture_focused = ImageTexture.create_from_image(Image.load_from_file("res://tiles/base_shiny.png"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_tower_draw():
	base()
	pass # Replace with function body.

func _on_tower_hidden():
	forest()
	pass # Replace with function body.

func _on_pressed():
	#print(focus)
	if focus:
		release_focus()
		tile_unfocused.emit()
	else:
		grab_click_focus()
		print('show vindow in tile')
		#print(focus)
		tile_focused.emit()
		#print(show_window.get_connections())
	focus = not focus
	#print(focus)
	#print("this tile is: ", self)
	
func get_tower_state():
	return $Tower.get_state()

func create_tower():
	$Tower.add()

func delete_tower():
	$Tower.delete()
