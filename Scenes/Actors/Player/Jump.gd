#Jump.gd
extends PlayerState

onready var timer : Timer = $JumpHoldTimer

func enter(msg = {}) -> void:
	timer.wait_time = player.jump_extension_limit
	timer.start()

func exit():
	timer.stop()

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("player_jump"):
		state_machine.transition_to("Fall")

func physics_update(delta: float) -> void: 
	if player.vertical_velocity != -player.jump_force:
		player.vertical_velocity = -player.jump_force
	player.velocity.y = player.vertical_velocity

func _on_JumpHoldTimer_timeout():
	print("auto stop!")
	state_machine.transition_to("Fall")
