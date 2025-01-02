class_name Waves
extends Node

@export var enemy_boat_scene: PackedScene

static var instance: Waves

func _ready() -> void:
	instance = self

func _process(delta: float) -> void:
	var enemies = get_enemies()
	if enemies.is_empty():
		create_wave_preview()
		wave_state = WaveState.Waiting
		wave_counter += 1
	elif enemies.any(func(b): return !b.controller.preview):
		wave_state = WaveState.Ongoing

static var wave_counter: int = 0
static var wave_state: WaveState = WaveState.Waiting

static func create_wave_preview():
	var boat: Boat = instance.enemy_boat_scene.instantiate()
	instance.add_sibling(boat)
	
	boat.position = Vector2(80, 80).lerp(Vector2(80, 1360), randf())

static func get_enemies() -> Array:
	return instance.get_tree().get_nodes_in_group("boats").filter(func(b):
		return b.controller is EnemyController)
static func get_preview_enemies() -> Array:
	return get_enemies().filter(func(b): return b.controller.preview)

static func start_wave():
	var previews = get_preview_enemies()
	for boat in previews:
		(boat.controller as EnemyController).preview = false


enum WaveState {
	Waiting, Ongoing
}
