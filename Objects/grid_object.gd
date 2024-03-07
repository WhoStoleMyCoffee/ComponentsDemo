class_name GridObject extends Node2D

const GRID_SIZE: Vector2i = Vector2i(32, 32)


var grid_pos: Vector2i: set = set_grid_pos


func _enter_tree():
	add_to_group(&"GridObjects")
	set_notify_transform(true)


func _notification(what: int):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		grid_pos = (position / 32.0).floor()

func set_grid_pos(p: Vector2i):
	grid_pos = p
	create_tween() .set_trans(Tween.TRANS_BACK) .set_ease(Tween.EASE_OUT)\
		.tween_property(self, ^"position", Vector2(grid_pos * GRID_SIZE), 0.2)


func get_component(component: StringName) -> Node:
	return get_meta(component, null)

func has_component(component: StringName) -> bool:
	return has_meta(component)

