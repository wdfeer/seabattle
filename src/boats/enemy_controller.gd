class_name EnemyController
extends Node

@onready var boat: Boat = $".."

var preview: bool = true
@onready var target: Boat = PlayerController.get_player(get_tree())

func _process(_delta: float) -> void:
	if preview:
		boat.modulate = Color.CRIMSON.lerp(Color.TRANSPARENT, 0.25)
	else:
		boat.modulate = Color.WHITE

func _physics_process(delta: float) -> void:
	if preview: return
	if target == null:
		victory_dance(delta)
		return
	
	process_movement(delta)
	process_shooting()

func victory_dance(delta: float):
	boat.steer(1, delta)
	if (int(Time.get_unix_time_from_system() * 1.5)) % 2 == 0:
		boat.sail_forward(delta) 

var ai_type: AiType = AiType.values().pick_random()
func process_movement(delta: float):
	var self_pos: Vector2 = boat.global_position
	var target_pos: Vector2 = target.global_position
	match (ai_type):
		AiType.Aggresive:
			var direction = self_pos.direction_to(target_pos)
			boat.sail(direction, delta)
		AiType.Passive:
			const safe_range = 400
			const margin = 100
			const ang_margin = PI / 16
			
			var angle_to_target = self_pos.angle_to(target_pos)
			var desired_angle = angle_to_target + PI / 2
			var velocity_mult = 1
			
			if self_pos.distance_to(target_pos) < safe_range:
				desired_angle += PI / 4
			elif self_pos.distance_to(target_pos) > safe_range + margin * 2:
				desired_angle -= PI / 2
			elif self_pos.distance_to(target_pos) > safe_range + margin:
				desired_angle -= PI / 4
			else:
				velocity_mult = 0.5
			var ang_delta = desired_angle - boat.velocity.angle()
			if abs(ang_delta) > ang_margin:
				var ang_dir = sign(ang_delta)
				boat.steer(ang_delta, delta)
			boat.sail_forward(velocity_mult)

func process_shooting():
	if boat.shooter.can_shoot():
		var dir = boat.global_position.direction_to(target.global_position)
		boat.shooter.shoot(dir)

enum AiType {
	Aggresive, Passive
}
