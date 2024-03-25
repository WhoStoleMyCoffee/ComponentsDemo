extends GridObject

@export var is_activated: bool = false
@onready var sprite = $Sprite


func _ready():
	sprite.frame = int(is_activated)


## Called from InteractableComponent
func _on_just_interacted(_interacted_by: GridObject):
	is_activated = !is_activated
	sprite.frame = int(is_activated)
	
	sprite.scale = Vector2(2.0, 0.5)
	sprite.rotation_degrees = 7.0
	
	var t: Tween = create_tween()\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)\
		.set_parallel()
	t.tween_property(sprite, ^"scale", Vector2.ONE, 0.2)
	t.tween_property(sprite, ^"rotation", 0.0, 0.2)


