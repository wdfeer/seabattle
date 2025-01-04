class_name BodyTypes

static var types: Array[PackedScene] = [
	preload("res://src/boats/bodies/canoe.tscn"),
	preload("res://src/boats/bodies/longship.tscn"),
	preload("res://src/boats/bodies/galley.tscn")
]

static func set_body_type(enemy: Boat, index: int):
	if enemy.has_node("Body"):
		var old_body = enemy.get_node("Body")
		enemy.remove_child(old_body)
		old_body.queue_free()
	var body: BoatBody = types[index].instantiate()
	body.name = "Body"
	enemy.add_child(body)
	enemy.body = body
