extends VBoxContainer

@export var first_location_label: Label
@onready var location_text = first_location_label.text

func _process(delta: float) -> void:
	var pos1: Vector2i = Locations.locations.keys()[0]
	first_location_label.text = location_text % [pos1.x, pos1.y]
