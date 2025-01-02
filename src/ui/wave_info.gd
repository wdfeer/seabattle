extends VBoxContainer

@export var title: Label

func _process(delta: float) -> void:
	if Waves.wave_state == Waves.WaveState.Waiting:
		title.text = "Incoming Wave:"
	else:
		title.text = "Current Wave:"
