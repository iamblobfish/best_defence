extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	pass
	

func _on_button_2_pressed():
	print('presses Hide')
	$HBoxContainer.hide()

func _on_button_pressed():
	print('presses Build')
	$TextureButton.show()
	$HBoxContainer.hide()
	



func _on_focus_entered():
	print("Pressed: ")
	#$HBoxContainer.show()
	$Window.show_add(['play', 'playplay'])
	$Window/VBoxContainer/Close.show()

func _on_focus_exited():
	#$HBoxContainer.hide()
	$Window/VBoxContainer/ItemList.clear()
	$Window/VBoxContainer/Close.hide()

	
	
	


func _on_window_close():
	release_focus()
	pass # Replace with function body.


func _on_window_create():
	$TextureButton.show()




func _on_window_delete():
	$TextureButton.hide()
	 # Replace with function body.
