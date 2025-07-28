class_name Waves
extends Node

@export var enemy_boat_scene: PackedScene

static var instance: Waves

func _ready() -> void:
	instance = self

func _process(_delta: float) -> void:
	var enemies = get_enemies()
	if enemies.is_empty():
		if wave_counter < wave_max:
			wave_state = WaveState.Waiting
			create_wave_preview()
			wave_counter += 1
			Sectors.sectors[Sectors.current] -= 1
		elif Sectors.sectors[Sectors.current] > 0:
			wave_counter = -1 # Off by one if 0, for some reason
			wave_max = Sectors.sectors[Sectors.current]
		else:
			wave_state = WaveState.Finished
			Sectors.sectors[Sectors.current] = 0
	elif enemies.any(func(b): return !b.controller.preview):
		wave_state = WaveState.Ongoing

static var wave_counter: int = 0
static var wave_max: int = Sectors.sectors[Sectors.current]
static var wave_state: WaveState = WaveState.Waiting

const sides_lines: Array[Array] = [
	[Vector2(80, 80), Vector2(80, 1360)],  # Left
	[Vector2(80, 80), Vector2(1360, 80)],  # Top
	[Vector2(1360, 80), Vector2(1360, 1360)],  # Right
	[Vector2(80, 1360), Vector2(1360, 1360)]  # Bottom
]
const sides_rotations: Array[float] = [0, PI / 2, PI, PI * 3 / 2]

static func create_wave_preview():
	assert(wave_state != WaveState.Finished)
	var enemy_count = 2 if wave_counter > 1 else 1
	for i in enemy_count:
		create_preview_enemy()
static func create_preview_enemy():
	var difficulty = Sectors.current.distance_to(Vector2i.ZERO)
	
	var boat: Boat = instance.enemy_boat_scene.instantiate()
	BodyTypes.set_body_type(boat, 0 if difficulty < 2 else
		randi_range(0, min(wave_counter, len(BodyTypes.types) - 1)))
	WeaponTypes.set_weapon(boat, randi_range(0, 1) if difficulty < 3 else
		randi_range(2, min(wave_counter, len(WeaponTypes.types) - 1)))
	instance.add_sibling(boat)
	
	var i = randi_range(0, 3)
	var side = sides_lines[i] as Array[Vector2]
	boat.global_position = side[0].lerp(side[1], randf())
	boat.rotation = sides_rotations[i]

static func get_enemies() -> Array:
	return instance.get_tree().get_nodes_in_group("boats").filter(func(b):
		return b.controller is EnemyController)
static func get_preview_enemies() -> Array:
	return get_enemies().filter(func(b): return b.controller.preview)

static func start_wave():
	assert(wave_state != WaveState.Finished)
	
	var previews = get_preview_enemies()
	for boat in previews:
		(boat.controller as EnemyController).preview = false


enum WaveState {
	Waiting, Ongoing, Finished
}
