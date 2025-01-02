class_name EnemyController
extends Node

@onready var boat: Boat = $".."

var preview: bool = true
@onready var target: Boat = PlayerController.get_player(get_tree())

func _process(delta: float) -> void:
	if preview:
		boat.modulate = Color.CRIMSON.lerp(Color.TRANSPARENT, 0.25)
	else:
		boat.modulate = Color.WHITE

func _physics_process(delta: float) -> void:
	if preview: return
	if target == null: return
	
	process_movement(delta)
	process_shooting(delta)

func process_movement(delta: float):
	var direction = boat.global_position.direction_to(target.global_position)
	boat.sail(direction, delta) # TODO: sophisticate movement, e.g. to surround the player

func process_shooting(delta: float):
	if boat.shooter.can_shoot():
		var dir = boat.global_position.direction_to(target.global_position)
		boat.shooter.shoot(dir)
