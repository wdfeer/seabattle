class_name Locations
extends Node

static var current_location: Vector2i = Vector2i.ZERO
static var locations: Dictionary = {
	Vector2i.ZERO: LocationType.Enemy
}
static func generate_locations(around: Vector2i):
	if !locations.has(around):
		printerr("Location", around, "doesn't exist!")
	else:
		locations.merge({
			around + Vector2i.UP: LocationType.Enemy,
			around + Vector2i.DOWN: LocationType.Enemy,
			around + Vector2i.LEFT: LocationType.Enemy,
			around + Vector2i.RIGHT: LocationType.Enemy
		})


enum LocationType {
	Enemy
}
