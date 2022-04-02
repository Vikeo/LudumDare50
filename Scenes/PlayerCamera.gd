extends Camera2D

onready var player : KinematicBody2D = get_parent()



func _on_StateMachine_transitioned(state_name) -> void:
	if state_name == "Fall":
		drag_margin_bottom = 0.0
		
	else:
		drag_margin_bottom = 0.7
