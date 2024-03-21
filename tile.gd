extends Hex

signal tile_focused
signal tile_unfocused
signal tower_update

var focus = false

var towers_scipts = {
	0 : "res://towers_scripts/base_tower.gd",
	1 : "res://towers_scripts/attack_base_tower.gd",
	2 : "res://towers_scripts/mining_tower.gd"
}

func _ready():
	set_hex(HexType.FOREST_WILD)
	pass # Replace with function body.

func _on_pressed():
	if focus:
		release_focus()
		tile_unfocused.emit()
	else:
		tile_focused.emit()
	focus = not focus

func _on_tower_draw():
	set_hex(HexType.FOREST_BUILT)

func _on_tower_hidden():
	set_hex(HexType.FOREST_WILD)
	
func get_tower_state():
	return $Tower.get_state()

func create_tower(tower_type):
	# TODO: why grab_focus needed?
	grab_focus()
	$Tower.set_script(load(towers_scipts[tower_type]))
	var result = $Tower.create_or_update()
	if (result == -1):
		$Tower.set_script(load(towers_scipts[0]))
		return -1
	tower_update.emit()

func delete_tower():
	grab_focus()
	$Tower.disassemble()
	$Tower.set_script(load(towers_scipts[0]))
	tower_update.emit()

func damage_tower(damage):
	$Tower.make_damage(damage)

func get_enemies():
	return get_parent().enemies.keys()
	
