extends GridObject


func _on_hittable_component_just_hit(hit_by):
	queue_free()
