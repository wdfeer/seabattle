class_name Sectors

static var current: Vector2i = Vector2i.ZERO
static var sectors: Dictionary = {
	Vector2i.ZERO: 3
}

# TODO: use this to generate sectors in all directions
static func generate_sectors(around: Vector2i):
	if !sectors.has(around):
		printerr("sector", around, "doesn't exist!")
	else:
		sectors.merge({
			around + Vector2i.UP: 3,
			around + Vector2i.DOWN: 3,
			around + Vector2i.LEFT: 3,
			around + Vector2i.RIGHT: 3
		})
