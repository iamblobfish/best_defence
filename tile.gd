extends Hex

signal tile_focused
signal tile_unfocused

var focus = false

var towers = {
	"Base" : "res://towers_scripts/base_tower.gd",
	"Attack" : "res://towers_scripts/attack_base_tower.gd",
	"Mining" : "res://towers_scripts/mining_tower.gd"
}

func _ready():
	set_hex(HexType.FOREST_WILD)
	pass # Replace with function body.

func _on_pressed():
	#print(focus)
	if focus:
		release_focus()
		tile_unfocused.emit()
	else:
		print('show vindow in tile')
		#print(focus)
		tile_focused.emit()
		#print(show_window.get_connections())
	focus = not focus

func _on_tower_draw():
	set_hex(HexType.FOREST_BUILT)
	pass # Replace with function body.

func _on_tower_hidden():
	set_hex(HexType.FOREST_WILD)
	pass # Replace with function body.
	
func get_tower_state():
	return $Tower.get_state()

func create_tower():
	#TODO: choise
	grab_focus()
	var choise = "Mining" 
	$Tower.set_script(load(towers[choise]))
	$Tower.create_or_update()
	

func delete_tower():
	grab_focus()
	$Tower.destroy()
	$Tower.set_script(load(towers['Base']))
