class_name Sectors

static var current_sector: Vector2i = Vector2i.ZERO
static var sectors: Dictionary = {
	Vector2i.ZERO: sectorType.Enemy
}
static func generate_sectors(around: Vector2i):
	if !sectors.has(around):
		printerr("sector", around, "doesn't exist!")
	else:
		sectors.merge({
			around + Vector2i.UP: sectorType.Enemy,
			around + Vector2i.DOWN: sectorType.Enemy,
			around + Vector2i.LEFT: sectorType.Enemy,
			around + Vector2i.RIGHT: sectorType.Enemy
		})

enum sectorType {
	Enemy
}
