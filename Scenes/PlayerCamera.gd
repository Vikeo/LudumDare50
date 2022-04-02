extends Camera2D

onready var player : KinematicBody2D = get_parent()

#var target_margin:float = 0.7
#
#
#func _process(delta: float) -> void:
#	drag_margin_bottom = lerp(drag_margin_bottom, target_margin, delta)
#
#func _on_StateMachine_transitioned(state_name) -> void:
#	if state_name == "Fall":
#		target_margin = 0.0
#
#	else:
#		target_margin = 0.0
