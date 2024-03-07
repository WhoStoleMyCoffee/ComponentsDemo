class_name Player extends GridObject


var level: Level

@onready var pushable_component = $PushableComponent


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
	if pushable_component.can_push(dir):
		grid_pos += dir

