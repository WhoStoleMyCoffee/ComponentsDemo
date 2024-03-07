class_name PushableComponent extends Node

func _enter_tree() -> void:
	# Make `owner` just a shorthand for `get_parent()`
	owner = get_parent() as GridObject
	owner.set_meta(&"PushableComponent", self)

func _exit_tree() -> void:
	owner.remove_meta(&"PushableComponent")


func push(dir: Vector2i) -> bool:
	var target_cell: Vector2i = owner.grid_pos + dir
	var level = get_tree().current_scene as Level
	if !level.cellv_exists(target_cell):
		return false
	
	var object: GridObject = level.get_cellv(target_cell)
	# There's something in the way
	if object != null:
		# Not pushable
		if !object.has_component(&"PushableComponent"):
			return false
		
		# Can't push
		var pc = object.get_component(&"PushableComponent") as PushableComponent
		if !pc.push(dir):
			return false
	
	get_parent().grid_pos += dir
	return true

