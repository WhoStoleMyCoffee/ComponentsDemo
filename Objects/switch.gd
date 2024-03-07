extends GridObject

const ACTIVATED_COLOR: Color = Color(1.0, 2.0, 2.0)
const DEACTIVATED_COLOR: Color = Color(0.54296875, 0.23128533363342, 0.18028259277344)

@export var is_activated: bool = false


func _ready():
	modulate = ACTIVATED_COLOR if is_activated else DEACTIVATED_COLOR


func _on_hittable_component_just_hit(hit_by):
	is_activated = !is_activated
	modulate = ACTIVATED_COLOR if is_activated else DEACTIVATED_COLOR
