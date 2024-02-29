extends Sprite2D

var towers = {
	0: "res://tiles/castles/castle1.png",
	1: "res://tiles/castles/castle2.png",
	2: "res://tiles/tower1.png",
	3: "res://tiles/castles/castle31.png"
	}

var tower = -1

func _ready():
	pass # Replace with function body.

func add():
	tower+=1
	if tower in towers:
		texture = ImageTexture.create_from_image(Image.load_from_file(towers[tower]))
		#TODO if hidden - show
		if tower == 0:
			show()
		return 0
	else:
		print("Maximum tower")
		return 1
	

func delete():
	hide()
	tower = -1

func updatable():
	return (tower+1 in towers)

func get_state():
	if tower == -1:
		return -1
	elif updatable():
		return 0
	else: return 1
	

	 

