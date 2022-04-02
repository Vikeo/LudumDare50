#Idle.gd
extends PlayerState

func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	
	
func update(delta: float) -> void:
	# If you have platforms that break when standing on them, you need that check for 
	# the character to fall.
#	if not player.is_on_floor():
#		state_machine.transition_to("Air")
#		return
		
	if Input.is_action_just_pressed("player_jump"):
		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
		# to tell the next state that we want to jump.
		state_machine.transition_to("Jump", {do_jump = true})
		
	if Input.is_action_just_pressed("player_left") or Input.is_action_just_pressed("player_right"):
		state_machine.transition_to("Run")
