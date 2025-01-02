class_name WaveGeneration
extends Node

@export var enemy_boat_scene: PackedScene

static var instance: WaveGeneration
func _ready() -> void:
	instance = self
	if get_preview_enemies().is_empty():
		create_wave_preview.call_deferred()

static var wave_counter: int = 0
static var wave_state: WaveState = WaveState.Waiting

static func create_wave_preview():
	var boat: Boat = instance.enemy_boat_scene.instantiate()
	instance.add_sibling(boat)
	
	boat.position = Vector2(80, 80).lerp(Vector2(80, 1360), randf())

static func get_preview_enemies() -> Array:
	return instance.get_tree().get_nodes_in_group("boats").filter(func(b):
		return b.controller is EnemyController and b.controller.preview)

static func start_wave():
	var previews = get_preview_enemies()
	for boat in previews:
		(boat.controller as EnemyController).preview = false


enum WaveState {
	Waiting, Ongoing
}
