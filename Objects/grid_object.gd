class_name GridObject extends Node2D

const GRID_SIZE: Vector2i = Vector2i(32, 32)


var grid_pos: Vector2i:
	set(v):
		grid_pos = v
		position = grid_pos * GRID_SIZE


func _enter_tree():
	add_to_group(&"GridObjects")
	set_notify_transform(true)


func _notification(what: int):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		grid_pos = (position / 32.0).floor()


func get_component(component: StringName) -> Node:
	return get_meta(component, null)

func has_component(component: StringName) -> bool:
	return has_meta(component)

