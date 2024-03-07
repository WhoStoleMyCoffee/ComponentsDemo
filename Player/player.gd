class_name Player extends GridObject


var level: Level


func _ready():
	level = get_tree().current_scene as Level


func _unhandled_key_input(event: InputEvent) -> void:
	if !(event is InputEventKey):
		return
	
	var movement_dir: Vector2i = Vector2i.ZERO
	if Input.is_action_just_pressed(&"up"):
		movement_dir = Vector2i.UP
	elif Input.is_action_just_pressed(&"down"):
		movement_dir = Vector2i.DOWN
	elif Input.is_action_just_pressed(&"left"):
		movement_dir = Vector2i.LEFT
	elif Input.is_action_just_pressed(&"right"):
		movement_dir = Vector2i.RIGHT
	
	if movement_dir != Vector2i.ZERO:
		move(movement_dir)


func move(dir: Vector2i) -> void:
	var target_cell: Vector2i = grid_pos + dir
	if !level.cellv_exists(target_cell):
		return
	
	var object: GridObject = level.get_cellv(target_cell)
	# There's something in the way
	if object != null:
		# Not pushable
		if !object.has_component(&"PushableComponent"):
			return
		
		# Can't push
		var pc = object.get_component(&"PushableComponent") as PushableComponent
		if !pc.push(dir):
			return
	
	grid_pos = target_cell

