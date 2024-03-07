extends GridObject


func _on_hittable_component_just_hit(_hit_by: GridObject):
	var t = create_tween()\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
	t.tween_property($Sprite2D, ^"scale", Vector2(0.5, 2.0), 0.1)
	t.tween_callback(queue_free)
