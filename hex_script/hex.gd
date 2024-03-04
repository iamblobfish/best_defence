extends TextureButton
class_name Hex 


enum HexType {
	BASE,
	FOREST_WILD,
	FOREST_BUILT
}

enum Mode {
	OK, SHINY
}

var textures = {
	HexType.BASE: {
		Mode.OK: 'res://tiles/hexes/base.png',
		Mode.SHINY: 'res://tiles/hexes/base_shiny.png' },
	HexType.FOREST_WILD: {
		Mode.OK: 'res://tiles/hexes/forest_new.png',
		Mode.SHINY: 'res://tiles/hexes/forest_new_shiny.png' },
	HexType.FOREST_BUILT: {
		Mode.OK: 'res://tiles/hexes/forest_new_cut.png',
		Mode.SHINY: 'res://tiles/hexes/forest_new_cut_shiny.png' 
	}
}

func set_hex(hex_type):
	texture_normal = ImageTexture.create_from_image(Image.load_from_file(textures[hex_type][Mode.OK]))
	texture_hover = ImageTexture.create_from_image(Image.load_from_file(textures[hex_type][Mode.SHINY]))
	texture_focused = ImageTexture.create_from_image(Image.load_from_file(textures[hex_type][Mode.SHINY]))
	

