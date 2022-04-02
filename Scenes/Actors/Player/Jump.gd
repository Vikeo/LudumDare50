#Jump.gd
extends PlayerState

export var jump_extension_limit : float = 1.0

onready var timer : Timer = $JumpHoldTimer

func enter(msg = {}) -> void:
	timer.wait_time = jump_extension_limit
	timer.start()
	print("Jump")

func exit():
	timer.stop()
	print("exiting")

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("player_jump"):
		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
		# to tell the next state that we want to jump.
		state_machine.transition_to("Fall")
		print("Stopped")

func physics_update(delta: float) -> void: 
	player.velocity.y = -player.jump_force

func _on_JumpHoldTimer_timeout():
	print("auto stop!")
	state_machine.transition_to("Fall")
