extends VBoxContainer

@export var first_sector_label: Label
@onready var sector_text = first_sector_label.text

func _process(delta: float) -> void:
	var pos1: Vector2i = sectors.sectors.keys()[0]
	first_sector_label.text = sector_text % [pos1.x, pos1.y]
