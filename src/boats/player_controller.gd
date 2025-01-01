extends Node

@onready var boat: Boat = $".."
@onready var body: BoatBody = $"../Body"

func _physics_process(delta: float) -> void:
	var vx = Input.get_axis("left", "right")
	var vy = Input.get_axis("up", "down")
	var direction = Vector2(vx, vy)
	boat.move(direction)
