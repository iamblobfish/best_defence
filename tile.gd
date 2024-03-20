extends Hex

signal tile_focused
signal tile_unfocused
signal tower_update

var focus = false

var towers = {
	0 : "res://towers_scripts/base_tower.gd",
	1 : "res://towers_scripts/attack_base_tower.gd",
	2 : "res://towers_scripts/mining_tower.gd"
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
		#print('show vindow in tile')
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
	
	

func create_tower(tower_type):
	grab_focus()
	#var choise = "Attack"
	$Tower.set_script(load(towers[tower_type+1]))
	var result = $Tower.create_or_update()
	if (result == -1):
		$Tower.set_script(load(towers[0]))
		return -1
	tower_update.emit()


func delete_tower():
	grab_focus()
	$Tower.disassemble()
	$Tower.set_script(load(towers[0]))
	tower_update.emit()
	

func damage_tower(damage):
	$Tower.make_damage(damage)

func get_enemies():
	return get_parent().enemies.keys()
	
