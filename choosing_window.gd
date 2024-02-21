extends PopupPanel


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_add(lst):
	for el in lst:
		$VBoxContainer/ItemList.add_item(el)
	$VBoxContainer.show()


func _on_create_pressed():
	print($VBoxContainer/ItemList.get_selected_items())
