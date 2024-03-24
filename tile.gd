extends Hex

signal tile_focused
signal tile_unfocused
signal tower_update

var focus = false

var towers_scipts = TowerDescriptions.tower_type_to_script_location

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
	# Destroy is needed in case if specialisation is built
	# For example, base attack -> multitarget
	$Tower.destroy()
	$Tower.set_script(load(towers_scipts[tower_type]))
	$Tower.on_tower_destroyed.connect(on_tower_destroyed)
	var result = $Tower.create_or_upgrade()
	if (result == -1):
		$Tower.set_script(load(towers_scipts[0]))
		return -1
	tower_update.emit()

func on_tower_destroyed():
	$Tower.set_script(load(towers_scipts[0]))
	tower_update.emit()

func delete_tower():
	grab_focus()
	$Tower.disassemble()

func upgrade_tower():
	grab_focus()
	$Tower.create_or_upgrade()

func damage_tower(damage):
	$Tower.make_damage(damage)

func get_enemies():
	return get_parent().enemies.keys()
	
