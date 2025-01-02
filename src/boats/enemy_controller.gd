extends Node

var preview: bool = true

@onready var boat: Boat = $".."

func _process(delta: float) -> void:
	if preview:
		boat.modulate = Color.CRIMSON.lerp(Color.TRANSPARENT, 0.25)
	else:
		boat.modulate = Color.WHITE
