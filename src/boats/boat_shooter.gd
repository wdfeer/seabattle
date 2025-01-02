class_name BoatShooter
extends Timer

@onready var boat: Boat = $".."

func _ready() -> void:
	wait_time = 1 / boat.fire_rate

func can_shoot() -> bool:
	return is_stopped()

func shoot(direction: Vector2):
	var proj: ProjectileSystem.Projectile = ProjectileSystem.create_projectile(
		boat.position,
		direction * boat.proj_velocity,
		boat.team)
	proj.damage = boat.proj_damage
	start()
