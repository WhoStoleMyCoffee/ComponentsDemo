class_name Player extends GridObject


var level: Level

@onready var pushable_component = $PushableComponent as PushableComponent


func _ready():
	level = get_tree().current_scene as Level


func _unhandled_key_input(event: InputEvent) -> void:
	if !(event is InputEventKey):
		return
	
	var movement_dir: Vector2i = Vector2i.ZERO
	if Input.is_action_pressed(&"up"):
		movement_dir = Vector2i.UP
	elif Input.is_action_pressed(&"down"):
		movement_dir = Vector2i.DOWN
	elif Input.is_action_pressed(&"left"):
		movement_dir = Vector2i.LEFT
	elif Input.is_action_pressed(&"right"):
		movement_dir = Vector2i.RIGHT
	
	if movement_dir != Vector2i.ZERO:
		move(movement_dir)


func move(dir: Vector2i) -> void:
	var target_cell: Vector2i = grid_pos + dir
	
	# Try to move & push whatever is in front
	if pushable_component.can_push(dir):
		grid_pos = target_cell
		return
	
	pushable_component.animate_push_fail(dir)
	
	# Hit stuff
	var object: GridObject = level.get_cellv(target_cell)
	if object == null:
		return
	if !object.has_component(&"InteractableComponent"):
		return
	
	object.get_component(&"InteractableComponent") .interact(self)

