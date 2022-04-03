extends Area2D

onready var player : KinematicBody2D = get_parent()

var rotation_offset : float = 0.0
var popped:bool = false

func _process(delta: float) -> void:
	if scale.x >= 10 or scale.y >= 10:
		popp_balloon()
		
	if popped == false:
		scale += Vector2.ONE * player.balloon_growth_mod
		
		Globals.score += 1
		
		if Input.is_action_just_released("player_left") or Input.is_action_just_released("player_right"):
			if( player.velocity.x > 0):
				rotation_offset = 20
			else:
				rotation_offset = -20
		else:
			rotation_offset = lerp(rotation_offset, 0, delta)
			
		var rotation_target = -(player.velocity.x * 0.15) + rotation_offset
		
		rotation_degrees = lerp(rotation_degrees, rotation_target, 10 * delta)

func _on_Balloon_area_entered(_area: Area2D) -> void:
	if _area.is_in_group("Spikes"):
		popp_balloon()
		
func popp_balloon() -> void:
	visible = false
	popped = true
	
