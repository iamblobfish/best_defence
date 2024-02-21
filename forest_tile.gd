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
	$HBoxContainer.hide()

func _on_button_pressed():
	$HBoxContainer.hide()
	$TextureButton.show()



func _on_focus_entered():
	print("Pressed: ")
	$HBoxContainer.show()
	$Window.show_add(['one', 'two'])
	$Window.show()


func _on_focus_exited():
	$HBoxContainer.hide()
	
