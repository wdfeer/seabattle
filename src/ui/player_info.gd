extends VBoxContainer

@export var hp_label: Label
@onready var hp_text = hp_label.text
@export var dmg_label: Label
@onready var dmg_text = dmg_label.text
@export var fire_rate_label: Label
@onready var fire_rate_text = fire_rate_label.text

func _process(delta: float) -> void:
	var player = PlayerController.get_player(get_tree())
	hp_label.text = hp_text % [player.hp, player.max_hp]
	dmg_label.text = dmg_text % player.proj_damage
	fire_rate_label.text = fire_rate_text % player.fire_rate
