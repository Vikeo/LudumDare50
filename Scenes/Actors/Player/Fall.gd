#Fall.gd
extends PlayerState

func physics_update(delta: float) -> void: 
	
	if player.vertical_velocity != player.max_gravity_force:
		player.vertical_velocity = player.max_gravity_force
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
