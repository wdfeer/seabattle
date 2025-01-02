class_name Crosshair
extends Node

const AIM_OFFSET: Vector2 = Vector2(16, 16)

@export var cursor: Texture2D
@export var crosshair: Texture2D

func _on_sea_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(crosshair)

func _on_sea_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(cursor)
