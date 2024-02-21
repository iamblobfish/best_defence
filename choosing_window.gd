extends PopupPanel
signal close
signal create
signal delete


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_add(lst):
	print(lst)
	for el in lst:
		print(el)
		print($VBoxContainer/ItemList.add_item(el))	
	show()
	
	



func _on_create_pressed():
	create.emit()
	pass # Replace with function body.


func _on_close_pressed():
	close.emit()
	hide()
	



func _on_delete_pressed():
	delete.emit()
	 # Replace with function body.
