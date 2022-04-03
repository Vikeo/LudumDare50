#Fall.gd
extends PlayerState

const landing_sound : AudioStreamSample = preload("res://SoundFx/Land.wav")

var wants_to_jump: bool = false

onready var buffer_timer : Timer = $BufferTimer

func enter(_msg = {}):
	wants_to_jump = false

func physics_update(delta: float) -> void: 
	
	if player.vertical_velocity != player.max_gravity_force:
		player.vertical_velocity = player.max_gravity_force
	
	if player.is_on_floor():
		if wants_to_jump == true:
			if Input.is_action_pressed("player_jump"):
				state_machine.transition_to("Jump", {buffered_jump = true})
			else:
				state_machine.transition_to("Jump", {buffered_jump = false})
		else:
			player.update_snap_vector()
			state_machine.transition_to("Idle")
		
		player.add_sound_effect(landing_sound, -10, true)
		player.add_landing_particle()
		return
	
	if player.input_vector.x != 0:
		player.velocity.x = lerp(player.velocity.x, player.max_speed * player.input_vector.x, player.air_friction * delta)

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("player_jump"):
		wants_to_jump = true
		buffer_timer.start(player.jump_buffer_time)

func _on_BufferTimer_timeout() -> void:
	wants_to_jump = false
