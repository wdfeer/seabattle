extends Area2D

@export var direction: Vector2i

func _process(_delta: float) -> void:
	visible = Waves.wave_state == Waves.WaveState.Finished
	monitoring = visible

func _on_body_entered(body: Node2D) -> void:
	if body is Boat and body.team == Boat.Team.Player:
		var pos = Sectors.current + direction
		Sectors.sectors.get_or_add(pos, 3)
		Sectors.current = pos
