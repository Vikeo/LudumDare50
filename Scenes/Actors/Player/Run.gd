#Run.gd
extends PlayerState

#func enter(_msg := {}) -> void:
#	pass

	
func physics_update(delta: float) -> void:
	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	
	player.input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	player.velocity.x = player.input_vector.x * player.max_speed
	#print(player.input_vector)
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
