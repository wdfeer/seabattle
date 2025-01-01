extends Node

@onready var boat: Boat = $".."

func _physics_process(delta: float) -> void:
	match ControlOptions.control_mode:
		ControlOptions.ControlMode.Direct:
			if Input.is_action_pressed("forward"):
				boat.sail_forward(delta)
				return
				
			var vx = Input.get_axis("left", "right")
			var vy = Input.get_axis("up", "down")
			var direction = Vector2(vx, vy)
			if direction.length() > 0:
				boat.sail(direction, delta)
		ControlOptions.ControlMode.Steering:
			var v_ang = Input.get_axis("left", "right")
			boat.steer(v_ang, delta)
			var v_parallel = Input.get_axis("down", "up")
			boat.sail_forward(delta * v_parallel)
