class_name Level extends Node2D


@onready var tile_map = $TileMap as TileMap


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_released(&"reset"):
		get_tree().reload_current_scene()
		# Tell the scene we handled this input
		get_viewport().set_input_as_handled()


## Returns the GridObject that the grid pos `pos`
## Warning: may return null
func get_cellv(pos: Vector2i) -> GridObject:
	for node in get_tree().get_nodes_in_group(&"GridObjects"):
		if node.grid_pos == pos:
			return node
	return null

## Returns whether the grid pos `pos` is occupied by some GridObject
func is_cellv_occupied(pos: Vector2i) -> bool:
	for node in get_tree().get_nodes_in_group(&"GridObjects"):
		if node.grid_pos == pos:
			return true
	return false

func cellv_exists(pos: Vector2i) -> bool:
	return tile_map.get_cell_tile_data(0, pos) != null
