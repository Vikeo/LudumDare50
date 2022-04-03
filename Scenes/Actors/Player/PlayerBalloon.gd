extends Area2D

const burst_sound : AudioStreamSample = preload("res://SoundFx/Burst.wav")

onready var player : KinematicBody2D = get_parent()

var rotation_offset : float = 0.0

func _process(delta: float) -> void:
	if Globals.popped:
		return
	
	if scale.x >= 10 or scale.y >= 10:
		popp_balloon()
	
	set_balloon_color()
	
	scale += Vector2.ONE * player.balloon_growth_mod
	
	Globals.score += 1
	Globals.balloon_size = scale.x
	
	
	if Input.is_action_just_released("player_left") or Input.is_action_just_released("player_right"):
		if( player.velocity.x > 0):
			rotation_offset = 20
		else:
			rotation_offset = -20
	else:
		rotation_offset = lerp(rotation_offset, 0, delta)
		
	var rotation_target = -(player.velocity.x * 0.15) + rotation_offset
	
	var scale_mod = clamp(1 - (scale.x * 0.1), 0, 1)
	
	rotation_degrees = lerp(rotation_degrees, rotation_target * scale_mod, 10 * delta)

func _on_Balloon_area_entered(_area: Area2D) -> void:
	if Globals.popped:
		return
	if _area.is_in_group("Spikes"):
		popp_balloon()
		
func popp_balloon() -> void:
	visible = false
	Globals.popped = true
	player.add_sound_effect(burst_sound)

func set_balloon_color() -> void:
	self.modulate = Color(player.base_color.r + (scale.x * 0.5), player.base_color.g - (scale.x * 0.1), player.base_color.b)
