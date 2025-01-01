extends Node

@onready var boat: Boat = $".."

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("forward"):
		boat.sail_forward(delta)
		return
	
	var vx = Input.get_axis("left", "right")
	var vy = Input.get_axis("up", "down")
	var direction = Vector2(vx, vy)
	if direction.length() > 0:
		boat.sail(direction, delta)
