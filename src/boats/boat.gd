class_name Boat
extends CharacterBody2D

@export var max_hp: float = 10
var hp: float = max_hp

@onready var body: BoatBody = $"Body"

func damage(amount: float):
	hp -= amount
	if hp <= 0:
		queue_free()

func move(direction: Vector2):
	velocity = direction * body.speed
	rotation = velocity.angle()
	move_and_slide()
