extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		
		
func _unhandled_input(event):
	if event is InputEventMagnifyGesture:
		print(event)
		if zoom - Vector2(1 - event.factor, 1 - event.factor) > Vector2(0.29, 0.29):
			zoom -= Vector2(1 - event.factor, 1 - event.factor)*0.5
	if event is InputEventPanGesture:
		print(event)
		offset += event.delta * 5
	if event is InputEventMouse:
		print(zoom)

