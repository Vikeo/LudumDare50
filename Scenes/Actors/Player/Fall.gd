#Fall.gd
extends PlayerState

func physics_update(delta: float) -> void: 
	
#	player.velocity.y = lerp(player.velocity.y, player.gravity_force, player.jump_force * delta)
	player.velocity.y = player.gravity_force
	print(player.velocity.y)
	
	if player.is_on_floor():
		print("ON FLOOR")
		state_machine.transition_to("Idle")
