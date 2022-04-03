#Jump.gd
extends PlayerState

const jumping_sound : AudioStreamSample = preload("res://SoundFx/Jump.wav")

onready var timer : Timer = $JumpHoldTimer
onready var min_timer : Timer = $MinimumTimer

var exiting_jump = false

func enter(msg = {}) -> void:
	player.snap_vector = Vector2.ZERO
	
	if msg.has("buffered_jump") and !msg.buffered_jump:
		exiting_jump = true
	else:
		exiting_jump = false
	
	timer.start(player.jump_extension_limit)
	min_timer.start(player.jump_minimum_limit)
	
	player.add_sound_effect(jumping_sound, -10, true)

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("player_jump"):
		exiting_jump = true

func physics_update(delta: float) -> void: 
	if exiting_jump and min_timer.is_stopped():
		state_machine.transition_to("Fall")
	if player.vertical_velocity != -player.jump_force:
		player.vertical_velocity = -player.jump_force
	player.velocity.y = player.vertical_velocity
	
	if player.input_vector.x != 0:
		player.velocity.x = lerp(player.velocity.x, player.max_speed * player.input_vector.x, player.air_friction * delta)

func exit():
	timer.stop()
	min_timer.stop()

func _on_JumpHoldTimer_timeout():
	state_machine.transition_to("Fall")
