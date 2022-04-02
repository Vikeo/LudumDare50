#Run.gd
extends PlayerState

export var idle_limit:float = 10.0


#func enter(_msg := {}) -> void:
#	pass

	
func physics_update(delta: float) -> void:
	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	
	player.input_vector.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	if player.input_vector.x != 0:
		
		player.velocity.x = lerp(player.velocity.x, player.max_speed * player.input_vector.x, player.acceleration * delta)
	else:
		
		player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
		print(player.velocity.x)
		
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if player.velocity.x < idle_limit and player.velocity.x > -idle_limit:
		state_machine.transition_to("Idle")

