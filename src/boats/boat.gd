class_name Boat
extends CharacterBody2D

@export var team: Boat.Team
@export var controller: Node

@export var weapon_name: String = "Hand Rifle"
@export var proj_damage: float = 1
@export var fire_rate: float = 3
@export var proj_velocity: float = 600

@onready var body: BoatBody = $Body
@onready var shooter: BoatShooter = $Shooter

@onready var hp: float = body.max_hp

func hittable() -> bool:
	return Waves.wave_state == Waves.WaveState.Ongoing

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
	
	sail_forward(1)

func sail_forward(mult: float):
	velocity = Vector2.from_angle(rotation) * body.speed * mult
	move_and_slide()


enum Team {
	Player, Enemy
}
