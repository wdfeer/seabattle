extends Node

@onready var boat: Boat = $".."

func _physics_process(delta: float) -> void:
	var vx = Input.get_axis("left", "right")
	var vy = Input.get_axis("up", "down")
	var direction = Vector2(vx, vy)
	if direction.length() > 0:
		boat.sail(direction, delta)
