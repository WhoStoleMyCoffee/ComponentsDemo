class_name InteractableComponent extends Node

signal just_interacted(interacted_by: GridObject)

@export var is_enabled: bool = true


func _enter_tree() -> void:
	# Make `owner` just a shorthand for `get_parent()`
	owner = get_parent() as GridObject
	owner.set_meta(&"InteractableComponent", self)

func _exit_tree() -> void:
	owner.remove_meta(&"InteractableComponent")


func interact(interacted_by: GridObject):
	if !is_enabled:
		return
	just_interacted.emit(interacted_by)

