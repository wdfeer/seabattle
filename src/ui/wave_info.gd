extends VBoxContainer

@export var title: Label
@export var wave_counter: Label
@onready var wave_counter_text = wave_counter.text
@export var ready_button: Button

@export var two_enemies_ui: Control
@onready var two_enemies_infos = two_enemies_ui.get_children().filter(func(n): return n is BoatInfo)

@export var single_enemy_info: BoatInfo

func _process(delta: float) -> void:
	if Waves.wave_state == Waves.WaveState.Waiting:
		title.text = "Incoming Wave:"
		ready_button.disabled = false
	else:
		title.text = "Current Wave:"
		ready_button.disabled = true
	
	wave_counter.text = wave_counter_text % Waves.wave_counter
	
	var enemies = Waves.get_enemies()
	var enemy_count = len(enemies)
	if enemy_count == 2:
		two_enemies_ui.visible = true
		single_enemy_info.visible = false
		for i in 2:
			two_enemies_infos[i] = enemies[i]
	elif enemy_count == 1:
		var enemy: Boat = enemies[0]
		two_enemies_ui.visible = false
		single_enemy_info.visible = true
		single_enemy_info.boat = enemy
	else:
		two_enemies_ui.visible = false
		single_enemy_info.visible = false
