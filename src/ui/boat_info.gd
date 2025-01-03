class_name BoatInfo
extends Node

@export var boat_label: Label
@export var hp_label: Label
@onready var hp_text = hp_label.text
@export var weapon_label: Label
@export var dmg_label: Label
@onready var dmg_text = dmg_label.text
@export var fire_rate_label: Label
@onready var fire_rate_text = fire_rate_label.text

var boat: Boat = null

var last_max_hp: float
func _process(_delta: float) -> void:
	if boat == null:
		hp_label.text = hp_text % [0, last_max_hp]
	else:
		last_max_hp = boat.body.max_hp
		boat_label.text = boat.body.boat_name
		hp_label.text = hp_text % [boat.hp, boat.body.max_hp]
		weapon_label.text = boat.weapon_name
		dmg_label.text = dmg_text % boat.proj_damage
		fire_rate_label.text = fire_rate_text % boat.fire_rate
