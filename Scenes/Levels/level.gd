class_name Level extends Node2D


@onready var tile_map = $TileMap as TileMap


## Warning: may return null
func get_cellv(pos: Vector2i) -> GridObject:
	for node in get_tree().get_nodes_in_group(&"GridObjects"):
		if node.grid_pos == pos:
			return node
	return null

func is_cellv_occupied(pos: Vector2i) -> bool:
	for node in get_tree().get_nodes_in_group(&"GridObjects"):
		if node.grid_pos == pos:
			return true
	return false

func cellv_exists(pos: Vector2i) -> bool:
	return tile_map.get_cell_tile_data(0, pos) != null
