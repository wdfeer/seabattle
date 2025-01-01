extends TextureRect

@export var next_scene: PackedScene

func load_next_scene():
	get_tree().change_scene_to_packed(next_scene)
