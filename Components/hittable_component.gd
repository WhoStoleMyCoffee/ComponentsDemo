class_name HittableComponent extends Node

signal just_hit(hit_by: GridObject)

@export var is_enabled: bool = true


func _enter_tree() -> void:
	# Make `owner` just a shorthand for `get_parent()`
	owner = get_parent() as GridObject
	owner.set_meta(&"HittableComponent", self)

func _exit_tree() -> void:
	owner.remove_meta(&"HittableComponent")


func hit(hit_by: GridObject):
	if !is_enabled:
		return
	just_hit.emit(hit_by)

