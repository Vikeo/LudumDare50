#Jump.gd
extends PlayerState

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

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("player_jump"):
		exiting_jump = true

func physics_update(_delta: float) -> void: 
	if exiting_jump and min_timer.is_stopped():
		state_machine.transition_to("Fall")
	if player.vertical_velocity != -player.jump_force:
		player.vertical_velocity = -player.jump_force
	player.velocity.y = player.vertical_velocity

func exit():
	timer.stop()
	min_timer.stop()

func _on_JumpHoldTimer_timeout():
	state_machine.transition_to("Fall")
