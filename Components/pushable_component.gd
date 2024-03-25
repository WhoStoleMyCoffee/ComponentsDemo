class_name PushableComponent extends Node

# In case we may want to disable it
@export var is_enabled: bool = true


func _enter_tree() -> void:
	# This component can only be a chld of GridObjects
	assert(owner is GridObject, "Owner must be a GridObject")
	owner.set_meta(&"PushableComponent", self) # Register

func _exit_tree() -> void:
	owner.remove_meta(&"PushableComponent") # Unregister


## Tries to push its GridObject owner in the direction `dir`
## Returns whether the push was successful
## This method is *recursive* (i.e. calls try_push() inside of try_push())
func try_push(dir: Vector2i) -> bool:
	if !is_enabled:
		return false
	
	var target_cell: Vector2i = owner.grid_pos + dir
	var level: Level = get_tree().current_scene
	
	# target_cell is out of bounds!
	if !level.cellv_exists(target_cell):
		animate_push_fail(dir)
		return false
	
	# Check if there's something in the way
	var object: GridObject = level.get_cellv(target_cell)
	# There's nothing in the way, we're good to move!
	if object == null:
		owner.grid_pos += dir
		return true
	
	# Not pushable
	if !object.has_component(&"PushableComponent"):
		animate_push_fail(dir)
		return false
	
	# At this point, we know there's an object in the way that is pushable
	# Try to push that
	var pc: PushableComponent = object.get_component(&"PushableComponent")
	if pc.try_push(dir): # Recursion happens here!
		# Success!
		owner.grid_pos += dir
		return true
	
	animate_push_fail(dir)
	return false


# Animates a little nudge for when a push failed
# For a cheat sheet of easing functions, please refer to this GOD TIER website:
# https://easings.net/
# by Andrey Sitnik and Ivan Solovev
func animate_push_fail(dir: Vector2):
	const DURATION: float = 0.1
	
	var t: Tween = create_tween() .set_trans(Tween.TRANS_SINE) .set_ease(Tween.EASE_OUT)
	
	t.tween_property(owner, ^"position", owner.position + Vector2(dir), DURATION)
	t.tween_property(owner, ^"position", owner.position, DURATION)

