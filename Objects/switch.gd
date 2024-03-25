extends GridObject

@export var is_activated: bool = false:
	# This setter method makes sure the sprite frame is always synced with `is_activated`
	set(v):
		is_activated = v
		sprite.frame = int(is_activated)

@onready var sprite = $Sprite


## Called from InteractableComponent
func _on_just_interacted(_interacted_by: GridObject):
	is_activated = !is_activated # This also updates the sprite thanks to the setter!
	
	sprite.scale = Vector2(2.0, 0.5)
	sprite.rotation_degrees = 7.0
	
	# Animate scale and rotation back to normal
	var t: Tween = create_tween()\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)\
		.set_parallel()
	t.tween_property(sprite, ^"scale", Vector2.ONE, 0.2)
	t.tween_property(sprite, ^"rotation", 0.0, 0.2)


