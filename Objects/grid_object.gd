class_name GridObject extends Node2D

const GRID_SIZE: Vector2i = Vector2i(32, 32)

## Grid pos in grid coordinates
## Always synced with this nodes's position
var grid_pos: Vector2i: set = set_grid_pos


func _enter_tree():
	add_to_group(&"GridObjects")
	set_notify_transform(true) # See func _notification()


## This method makes sure the grid_pos is always synced to the position
## It essentially gets called every time the transform (position, rotation, scale)
##  changes
func _notification(what: int):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		grid_pos = (position / 32.0).floor()

## This setter method takes care of animating the position when the
## grid_pos changes
func set_grid_pos(p: Vector2i):
	grid_pos = p
	create_tween()\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)\
		.tween_property(self, ^"position", Vector2(grid_pos * GRID_SIZE), 0.2)


#region Util - These are only for quality of life / readability

func get_component(component: StringName) -> Node:
	return get_meta(component, null)

func has_component(component: StringName) -> bool:
	return has_meta(component)

#endregion
