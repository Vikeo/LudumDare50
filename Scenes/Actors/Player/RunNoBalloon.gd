#RunNoBalloon.gd
extends PlayerState

#func enter(_msg := {}) -> void:
#	pass
	
func physics_update(delta: float) -> void:
	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	
	if !Input.is_action_pressed("player_modifiy"):
		state_machine.transition_to("Run")
	
	player.input_vector.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	if player.input_vector.x < 0:
		if player.velocity.x > -player.nb_turn_limit:
			player.velocity.x = lerp(player.velocity.x, player.nb_max_speed * player.input_vector.x, player.nb_friction * delta)
		else:
			player.velocity.x = lerp(player.velocity.x, player.nb_max_speed * player.input_vector.x, player.nb_acceleration * delta)
	elif player.input_vector.x >= 0:
		if player.velocity.x < player.nb_turn_limit:
			player.velocity.x = lerp(player.velocity.x, player.nb_max_speed * player.input_vector.x, player.nb_friction * delta)
		else:
			player.velocity.x = lerp(player.velocity.x, player.nb_max_speed * player.input_vector.x, player.nb_acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.nb_friction * delta)
	
	if player.velocity.x < player.nb_idle_limit and player.velocity.x > -player.nb_idle_limit and player.input_vector.x == 0:
		state_machine.transition_to("Idle")

