extends Area2D

func _process(delta: float) -> void:
	visible = Waves.wave_state == Waves.WaveState.Finished
	monitoring = visible

func _on_body_entered(body: Node2D) -> void:
	if body is Boat and body.team == Boat.Team.Player:
		var pos = Sectors.current + Vector2i.RIGHT
		Sectors.sectors.get_or_add(pos, 3)
		Sectors.current = pos
