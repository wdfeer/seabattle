class_name Boat
extends CharacterBody2D

@export var max_hp: float = 10
var hp: float = max_hp

@onready var body: BoatBody = $"Body"

func damage(amount: float):
	hp -= amount
	if hp <= 0:
		queue_free()

func steer(ang_direction: float, delta: float):
	rotation += delta * body.turn_speed * ang_direction

func sail(direction: Vector2, delta: float):
	var dir_angle = direction.angle()
	# Normalize the angular difference to [-PI, PI]
	var angle_diff = wrapf(dir_angle - rotation, -PI, PI)
	
	if abs(angle_diff) > 0.01:  # Small threshold to avoid jittering
		steer(sign(angle_diff), delta)
	
	sail_forward(delta)

func sail_forward(delta: float):
	velocity = Vector2.from_angle(rotation) * body.speed * delta
	move_and_slide()
