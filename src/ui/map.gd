class_name Minimap
extends TextureRect

static var instance: Minimap

func _ready() -> void:
	instance = self
	update_map()

func update_map():
	var image = Image.create(7, 7, false, Image.FORMAT_RGBA8)
	for x in range(-3, 3):
		for y in range(-3, 3):
			if Sectors.sectors.has(Sectors.current + Vector2i(x, y)):
				image.set_pixel(x + 3, y + 3, Color.RED)
	var texture = ImageTexture.create_from_image(image)
	(material as ShaderMaterial).set_shader_parameter("fill_map", texture)
