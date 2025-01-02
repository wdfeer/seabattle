class_name ProjectileSystem
extends ColorRect

static var projectiles: Array[Projectile] = []

static func create_projectile(pos: Vector2, velocity: Vector2, team: Boat.Team) -> Projectile:
	var proj = Projectile.new()
	proj.pos = pos
	proj.vel = velocity
	proj.team = team
	projectiles.append(proj)
	return proj

func _process(delta: float) -> void:
	var mat: ShaderMaterial = material
	mat.set_shader_parameter("circle_count", len(projectiles))
	mat.set_shader_parameter("circle_centers", projectiles.map(func(p): return p.pos))

func _physics_process(delta: float) -> void:
	for p in projectiles:
		p.pos += p.vel * delta
		p.life -= delta
		# TODO: process collisions
	projectiles = projectiles.filter(func(p): return p.life > 0)

class Projectile:
	var pos: Vector2
	var vel: Vector2
	var life: float = 2
	var team: Boat.Team
	var damage: float
