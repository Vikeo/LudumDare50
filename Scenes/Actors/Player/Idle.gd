#Idle.gd
extends PlayerState



func enter(_msg := {}) -> void:
	pass
	
func update(delta: float) -> void:
	# If you have platforms that break when standing on them, you need that check for 
	# the character to fall.
	if not player.is_on_floor():
		state_machine.transition_to("Fall")
		return
		
	if Input.is_action_just_pressed("player_jump"):
		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
		# to tell the next state that we want to jump.
		state_machine.transition_to("Jump")
		
	if Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
			state_machine.transition_to("Run")

func physics_update(delta: float) -> void:
	
	if player.vertical_velocity != player.max_gravity_force:
		player.vertical_velocity = player.max_gravity_force
		
	if player.velocity.x < player.idle_limit and player.velocity.x > -player.idle_limit:
		player.velocity.x = 0
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
