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

func _process(_delta: float) -> void:
	var mat: ShaderMaterial = material
	mat.set_shader_parameter("circle_count", len(projectiles))
	mat.set_shader_parameter("circle_centers", projectiles.map(func(p): return p.pos))

func _physics_process(delta: float) -> void:
	var nodes: Array[Node] = get_tree().get_nodes_in_group("boats").filter(
		func(x): return x is Boat and x.hittable())
	var boats = nodes as Array[Boat]
	for p in projectiles:
		p.pos += p.vel * delta
		p.life -= delta
		for b in boats:
			if b.team != p.team and p.collides(b):
				b.damage(p.damage)
				p.life = -1
				break
	projectiles = projectiles.filter(func(p): return p.life > 0)

class Projectile:
	var pos: Vector2
	var vel: Vector2
	var life: float = 2
	var team: Boat.Team
	var damage: float
	
	func collides(boat: Boat) -> bool:
		var projShape = CircleShape2D.new()
		projShape.radius = 3
		var projTransform = Transform2D(0, pos)
		var boatShape = ConvexPolygonShape2D.new()
		boatShape.points = boat.body.polygon
		return projShape.collide(projTransform, boatShape, boat.body.global_transform)
