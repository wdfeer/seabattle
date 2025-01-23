extends BoxContainer

@export var wave_info: BoxContainer
@export var location_info: BoxContainer

func _process(delta: float) -> void:
	location_info.visible = Waves.wave_state == Waves.WaveState.Finished
	wave_info.visible = Waves.wave_state != Waves.WaveState.Finished
