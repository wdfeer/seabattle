class_name Sectors

static var current: Vector2i = Vector2i.ZERO
static var sectors: Dictionary = {
	Vector2i.ZERO: 1
}

static func switch(delta: Vector2i, scene_tree: SceneTree):
	var pos := current + delta
	Sectors.sectors.get_or_add(pos, 1)
	Sectors.current = pos
	
	var player_boat = PlayerController.get_player(scene_tree)
	delta.y *= -1
	player_boat.position = Vector2i(720, 720) - delta * 600
	
	Minimap.instance.update_map()
