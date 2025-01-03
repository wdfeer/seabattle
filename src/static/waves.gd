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

const sides_lines: Array = [
	[Vector2(80, 80), Vector2(80, 1360)],  # Left
	[Vector2(80, 80), Vector2(1360, 80)],  # Top
	[Vector2(1360, 80), Vector2(1360, 1360)],  # Right
	[Vector2(80, 1360), Vector2(1360, 1360)]  # Bottom
]
const sides_rotations: Array[float] = [0, PI / 2, PI, PI * 3 / 2]

static func create_wave_preview():
	var enemy_count = 2 if wave_counter > 1 else 1
	for i in enemy_count:
		create_preview_enemy()
static func create_preview_enemy():
	var boat: Boat = instance.enemy_boat_scene.instantiate()
	instance.add_sibling(boat)
	
	var i = randi_range(0, 3)
	var side = sides_lines[i] as Array[Vector2]
	boat.global_position = side[0].lerp(side[1], randf())
	boat.rotation = sides_rotations[i]
	WeaponTypes.set_weapon(boat, randi_range(0, 1) if wave_counter < 3 else randi_range(2, len(WeaponTypes.types)))

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
