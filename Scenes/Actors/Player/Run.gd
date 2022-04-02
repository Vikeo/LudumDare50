#Run.gd
extends PlayerState

export var idle_limit:float = 1.0
export var turn_limit:float = 20.0


#func enter(_msg := {}) -> void:
#	pass
	
func physics_update(delta: float) -> void:
	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	if Input.is_action_just_pressed("player_jump"):
		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
		# to tell the next state that we want to jump.
		state_machine.transition_to("Jump")
	
	player.input_vector.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	if player.input_vector.x < 0:
		if player.velocity.x > -turn_limit:
			player.velocity.x = lerp(player.velocity.x, player.max_speed * player.input_vector.x, player.friction * delta)
		else:
			player.velocity.x = lerp(player.velocity.x, player.max_speed * player.input_vector.x, player.acceleration * delta)
	elif player.input_vector.x >= 0:
		if player.velocity.x < turn_limit:
			player.velocity.x = lerp(player.velocity.x, player.max_speed * player.input_vector.x, player.friction * delta)
		else:
			player.velocity.x = lerp(player.velocity.x, player.max_speed * player.input_vector.x, player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
	
	if player.velocity.x < idle_limit and player.velocity.x > -idle_limit and player.input_vector.x == 0:
		state_machine.transition_to("Idle")
		
	if Input.is_action_pressed("player_modifiy"):
		state_machine.transition_to("RunNoBalloon")

