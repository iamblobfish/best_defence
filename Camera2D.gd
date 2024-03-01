extends Camera2D

func _ready():
	pass 
		
		
func _unhandled_input(event):
	if event is InputEventMagnifyGesture:
		if zoom - Vector2(1 - event.factor, 1 - event.factor) > Vector2(0.29, 0.29):
			zoom -= Vector2(1 - event.factor, 1 - event.factor)*0.5
	if event is InputEventPanGesture:
		offset += event.delta * 5

