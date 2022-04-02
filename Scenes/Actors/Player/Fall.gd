#Fall.gd
extends PlayerState

var wants_to_jump: bool = false

onready var buffer_timer : Timer = $BufferTimer

func enter(msg = {}):
	wants_to_jump = false

func physics_update(delta: float) -> void: 
	
	if player.vertical_velocity != player.max_gravity_force:
		player.vertical_velocity = player.max_gravity_force
	
	if player.is_on_floor():
		if wants_to_jump == true:
			state_machine.transition_to("Jump")
		else:
			state_machine.transition_to("Idle")

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("player_jump"):
		wants_to_jump = true
		buffer_timer.start(player.jump_buffer_time)


func _on_BufferTimer_timeout() -> void:
	wants_to_jump = false
