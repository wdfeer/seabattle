extends VBoxContainer

@export var title: Label
@onready var title_text = title.text
@export var boat_info: BoatInfo

func _process(_delta: float) -> void:
	var player: Boat = PlayerController.get_player(get_tree())
	boat_info.boat = player
	if player == null:
		title.text = title_text + " DEAD"
