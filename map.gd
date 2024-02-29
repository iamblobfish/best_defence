extends Node2D
var tile_map = {}
var focused_tile = null
var margin = Vector2(100, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Window.create.connect(_on_window_create)
	$Window.delete.connect(_on_window_delete)
	$Window.btn3.connect(_on_window_btn3)
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


func _process(delta):
	pass

func on_tile_focused(tile):
	print("The clicked tile is: ", tile)
	var tower_state = tile.get_tower_state()
	focused_tile = tile
	#TODO: make window always be over other nodes
	$Window/VBoxContainer/btn3.hide()
	$Window/VBoxContainer/Create.hide()
	$Window/VBoxContainer/delete.hide()
	if tower_state==-1:
		$Window/VBoxContainer/Create.show()
	else:
		$Window/VBoxContainer/delete.show()
		if not tower_state:
			$Window/VBoxContainer/btn3.show()
	$Window.show()

func on_tile_unfocused(tile):
	print("Unfocus")
	focused_tile = null
	$Window.hide()

func _on_window_btn3():
	pass

#func _input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			#var global_clicked = event.position
			#print(global_clicked)

func _on_window_create():
	print('create on ', focused_tile)
	if focused_tile:
		focused_tile.create_tower()

func _on_window_delete():
	if focused_tile:
		focused_tile.delete_tower()
