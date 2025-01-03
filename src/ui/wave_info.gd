extends VBoxContainer

@export var title: Label
@export var wave_counter: Label
@onready var wave_counter_text = wave_counter.text
@export var ready_button: Button
@export var boat_info: BoatInfo

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
		boat_info.boat = enemy
	else:
		boat_info.boat = null
