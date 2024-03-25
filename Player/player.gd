class_name Player extends GridObject

# Due to some coincidences of similar movement mechanics, the player...
# is technically pushable (i.e. has a PushableComponent)...
# According to this implementation, the player is technically pushing themselves to move...
# Please don't copy this in your own projects, this was a mere coincidence lol

var level: Level

@onready var pushable_component = $PushableComponent as PushableComponent


func _ready():
	level = get_tree().current_scene as Level


func _unhandled_key_input(event: InputEvent):
	# We only want to register input events when they're pressed
	# Try seeing what happens if we comment this `guard clause` out!
	if !event.is_pressed():
		return
	
	# Move
	var movement_dir: Vector2i = Vector2i.ZERO
	if event.is_action(&"up", true):
		movement_dir = Vector2i.UP
	elif event.is_action(&"down", true):
		movement_dir = Vector2i.DOWN
	elif event.is_action(&"left", true):
		movement_dir = Vector2i.LEFT
	elif event.is_action(&"right", true):
		movement_dir = Vector2i.RIGHT
	
	if movement_dir != Vector2i.ZERO:
		move(movement_dir)
		# Tell the scene we handled this input
		get_viewport().set_input_as_handled()


## Tries to move in the direction `dir`
func move(dir: Vector2i) -> void:
	var target_cell: Vector2i = grid_pos + dir
	
	if pushable_component.try_push(dir):
		return
	
	# Push failed; try to interact with stuff
	var object: GridObject = level.get_cellv(target_cell)
	# `Level::get_cellv()` can return null, let's handle that just in case
	if object == null:
		return
	# Object is not interactable; return
	if !object.has_component(&"InteractableComponent"):
		return
	
	object.get_component(&"InteractableComponent") .interact(self)

