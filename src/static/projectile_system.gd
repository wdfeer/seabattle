class_name ProjectileSystem
extends ColorRect

static var instance: ProjectileSystem

func _ready() -> void:
	instance = self



class Projectile:
	var pos: Vector2
	var life: float
