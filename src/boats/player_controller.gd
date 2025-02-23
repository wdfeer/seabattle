class_name PlayerController
extends Node

@onready var boat: Boat = $".."

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_control_mode"):
		match ControlOptions.movement_mode:
			ControlOptions.MovementMode.Direct:
				ControlOptions.movement_mode = ControlOptions.MovementMode.Steering
			ControlOptions.MovementMode.Steering:
				ControlOptions.movement_mode = ControlOptions.MovementMode.Direct
	
	process_movement(delta)
	process_shooting(delta)

func process_movement(delta: float):
	match ControlOptions.movement_mode:
		ControlOptions.MovementMode.Direct:	
			var vx = Input.get_axis("left", "right")
			var vy = Input.get_axis("up", "down")
			var direction = Vector2(vx, vy)
			boat.sail(direction, delta, PI / 256)
		ControlOptions.MovementMode.Steering:
			var v_ang = Input.get_axis("left", "right")
			boat.steer(v_ang, delta)
			var v_parallel = Input.get_axis("down", "up")
			boat.sail_forward(v_parallel)

func process_shooting(_delta: float):
	if Input.is_action_pressed("shoot") and boat.shooter.can_shoot():
		var dir = boat.global_position.direction_to(boat.get_global_mouse_position() + Crosshair.AIM_OFFSET)
		boat.shooter.shoot(dir)

static func get_player(tree: SceneTree) -> Boat:
	var player_boats = tree.get_nodes_in_group("boats").filter(func(b): return b.team == Boat.Team.Player)
	if player_boats.is_empty():
		return null
	return player_boats[0]
