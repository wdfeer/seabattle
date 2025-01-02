extends VBoxContainer

@export var title: Label
@onready var title_text = title.text
@export var hp_label: Label
@onready var hp_text = hp_label.text
@export var dmg_label: Label
@onready var dmg_text = dmg_label.text
@export var fire_rate_label: Label
@onready var fire_rate_text = fire_rate_label.text

var last_player_max_hp: float

func _process(_delta: float) -> void:
	var player: Boat = PlayerController.get_player(get_tree())
	if player == null:
		hp_label.text = hp_text % [0, last_player_max_hp]
		title.text = title_text + " DEAD"
	else:
		last_player_max_hp = player.max_hp
		hp_label.text = hp_text % [player.hp, player.max_hp]
		dmg_label.text = dmg_text % player.proj_damage
		fire_rate_label.text = fire_rate_text % player.fire_rate
