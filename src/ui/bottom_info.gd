extends BoxContainer

@export var wave_info: BoxContainer
@export var sector_info: BoxContainer

func _process(_delta: float) -> void:
	sector_info.visible = Waves.wave_state == Waves.WaveState.Finished
	wave_info.visible = Waves.wave_state != Waves.WaveState.Finished
