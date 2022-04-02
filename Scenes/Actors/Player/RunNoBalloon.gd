#RunNoBalloon.gd
extends PlayerState

#Reference values.
#export var acceleration:float = 10.0
#export var friction:float = 5.0
#export var max_speed:float = 500.0
#export var jump_force:float = 200.0
#export var gravity_force:float = 30.0

#export var idle_limit:float = 1.0
#export var turn_limit:float = 20.0

export var nb_idle_limit:float = 1.0
export var nb_turn_limit:float = 20.0

export var nb_acceleration:float = 10.0
export var nb_friction:float = 5.0
export var nb_max_speed:float = 250.0
export var nb_jump_force:float = 200.0
export var nb_gravity_force:float = 30.0

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
		if player.velocity.x > -nb_turn_limit:
			player.velocity.x = lerp(player.velocity.x, nb_max_speed * player.input_vector.x, nb_friction * delta)
		else:
			player.velocity.x = lerp(player.velocity.x, nb_max_speed * player.input_vector.x, nb_acceleration * delta)
	elif player.input_vector.x >= 0:
		if player.velocity.x < nb_turn_limit:
			player.velocity.x = lerp(player.velocity.x, nb_max_speed * player.input_vector.x, nb_friction * delta)
		else:
			player.velocity.x = lerp(player.velocity.x, nb_max_speed * player.input_vector.x, nb_acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, nb_friction * delta)
	
	if player.velocity.x < nb_idle_limit and player.velocity.x > -nb_idle_limit and player.input_vector.x == 0:
		state_machine.transition_to("Idle")

