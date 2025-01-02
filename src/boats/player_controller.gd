extends Node

@onready var boat: Boat = $".."

func _physics_process(delta: float) -> void:
	process_movement(delta)
	process_shooting(delta)

func process_movement(delta: float):
	match ControlOptions.movement_mode:
		ControlOptions.MovementMode.Direct:
			if Input.is_action_pressed("forward"):
				boat.sail_forward(delta)
				return
				
			var vx = Input.get_axis("left", "right")
			var vy = Input.get_axis("up", "down")
			var direction = Vector2(vx, vy)
			if direction.length() > 0:
				boat.sail(direction, delta)
		ControlOptions.MovementMode.Steering:
			var v_ang = Input.get_axis("left", "right")
			boat.steer(v_ang, delta)
			var v_parallel = Input.get_axis("down", "up")
			boat.sail_forward(delta * v_parallel)

func process_shooting(delta: float):
	if Input.is_action_pressed("shoot") and boat.shooter.can_shoot():
		var dir = boat.global_position.direction_to(boat.get_global_mouse_position() + Crosshair.AIM_OFFSET)
		boat.shooter.shoot(dir)
