class_name PushableComponent extends Node

func _enter_tree() -> void:
	# Make `owner` just a shorthand for `get_parent()`
	owner = get_parent() as GridObject
	owner.set_meta(&"PushableComponent", self)

func _exit_tree() -> void:
	owner.remove_meta(&"PushableComponent")


func can_push(dir: Vector2i) -> bool:
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
	return true



func push(dir: Vector2i) -> bool:
	if !can_push(dir):
		var t = create_tween() .set_trans(Tween.TRANS_SINE) .set_ease(Tween.EASE_OUT)
		t.tween_property(owner, ^"position", owner.position + Vector2(dir), 0.1)
		t.tween_property(owner, ^"position", Vector2(owner.grid_pos * GridObject.GRID_SIZE), 0.1)
		return false
	owner.grid_pos += dir
	return true

