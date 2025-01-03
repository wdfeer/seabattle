extends VBoxContainer

@export var title: Label
@export var wave_counter: Label
@onready var wave_counter_text = wave_counter.text
@export var ready_button: Button

@export var boat_label: Label
@export var hp_label: Label
@onready var hp_text = hp_label.text
@export var dmg_label: Label
@onready var dmg_text = dmg_label.text
@export var fire_rate_label: Label
@onready var fire_rate_text = fire_rate_label.text

func _process(delta: float) -> void:
	if Waves.wave_state == Waves.WaveState.Waiting:
		title.text = "Incoming Wave:"
		ready_button.disabled = false
	else:
		title.text = "Current Wave:"
		ready_button.disabled = true
	
	wave_counter.text = wave_counter_text % Waves.wave_counter
	
	var enemies = Waves.get_enemies()
	if !enemies.is_empty():
		var enemy: Boat = enemies[0]
		boat_label.text = enemy.body.boat_name
		hp_label.text = hp_text % enemy.hp
		dmg_label.text = dmg_text % enemy.proj_damage
		fire_rate_label.text = fire_rate_text % enemy.fire_rate
