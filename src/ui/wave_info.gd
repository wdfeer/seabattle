extends VBoxContainer

@export var title: Label
@export var wave_counter: Label
@onready var wave_counter_text = wave_counter.text
@export var ready_button: Button

@export var enemies_ui: Control
@onready var enemies_infos = enemies_ui.get_children().filter(func(n): return n is BoatInfo)

func _process(_delta: float) -> void:
	match Waves.wave_state:
		Waves.WaveState.Waiting:
			title.text = "Incoming Wave:"
			ready_button.disabled = false
		Waves.WaveState.Ongoing:
			title.text = "Current Wave:"
			ready_button.disabled = true
	
	wave_counter.visible = Waves.wave_max != 1
	wave_counter.text = wave_counter_text % [Waves.wave_counter, Waves.wave_max]
	
	var enemies = Waves.get_enemies()
	if enemies.is_empty():
		enemies_ui.visible = false
	else:
		enemies_ui.visible = true
		for i in len(enemies_infos):
			if len(enemies) > i:
				enemies_infos[i].boat = enemies[i]
				enemies_infos[i].visible = true
			else:
				enemies_infos[i].boat = null
				enemies_infos[i].visible = false
