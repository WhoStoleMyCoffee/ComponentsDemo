extends GridObject

## Called from InteractableComponent
func _on_just_interacted(_interacted_by: GridObject):
	# Break animation
	# Although it's more of a "pop" than a "break"
	var t: Tween = create_tween()\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
	t.tween_property($Sprite2D, ^"scale", Vector2(0.5, 2.0), 0.1)
	t.tween_callback(queue_free)


