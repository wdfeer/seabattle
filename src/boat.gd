extends Node2D

@export var max_hp: float
var hp: float = max_hp

func damage(amount: float):
	hp -= amount
	if hp <= 0:
		queue_free()
