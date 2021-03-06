class_name Player
extends KinematicBody2D

const level_select_path = ("res://LevelSelect.tscn")

const sound_effect_player = preload("res://Scenes/Effects/AudioEffect.tscn")
const landing_particles = preload("res://Scenes/Effects/LandingSmoke.tscn")


const deflate_sound : AudioStreamSample = preload("res://SoundFx/Shrink.wav")

#Player exports
export var acceleration:float = 10.0
export var friction:float = 5.0
export var air_friction:float = 2.0
export var max_speed:float = 500.0

export var jump_force:float = 500.0
export var max_gravity_force:float = 500.0

#Run exports
export var idle_limit:float = 1.0
export var turn_limit:float = 20.0

#NoBalloon
export var nb_acceleration:float = 20.0
export var nb_friction:float = 20.0
export var nb_air_friction:float = 5.0
export var nb_max_speed:float = 300.0
export var nb_jump_force:float = 500.0
export var nb_max_gravity_force:float = 700.0

export var nb_idle_limit:float = 100.0
export var nb_turn_limit:float = 20.0

#Ballon exports
export var balloon_growth_mod : float = 0.008
export var base_color: Color = Color(1.5, 1.5, 0.5)

#JumpExports
export var jump_extension_limit : float = 0.5
export var jump_minimum_limit : float = 0.1

export var jump_buffer_time : float = 0.1

export var nb_jump_extension_limit : float = 0.2


var velocity:Vector2 = Vector2.ZERO
var input_vector:Vector2 = Vector2.ZERO
var vertical_velocity:float = 0.0
var snap_vector: Vector2 = Vector2.DOWN

#onready var
onready var sprite : AnimatedSprite = $Sprite
onready var balloon : Area2D = $Balloon

# Called when the node enters the scene tree for the first time.
func _ready():
	vertical_velocity = max_gravity_force
	Globals.popped = false
	Globals.reset_score()
	balloon.scale.x = 1
	balloon.scale.y = 1
	randomize()

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_reload"):
		reset_scene()
		
	if Globals.popped:
		acceleration = nb_acceleration
		friction = nb_friction
		air_friction = nb_air_friction
		max_speed = nb_max_speed
		jump_force = nb_jump_force
		max_gravity_force = nb_max_gravity_force
		idle_limit = nb_idle_limit
		turn_limit = nb_turn_limit
		jump_extension_limit = nb_jump_extension_limit
		
	input_vector.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	
	if input_vector.x < 0:
		sprite.flip_h = true
	elif input_vector.x > 0:
		sprite.flip_h = false

func apply_gravity(delta : float) -> void:
	velocity.y = lerp(velocity.y, vertical_velocity, air_friction * delta)
	
func update_snap_vector() -> void:
	if is_on_floor():
		snap_vector = -get_floor_normal()
	else:
		snap_vector = Vector2.ZERO

func update_animation_speed(speed: float = 0.0) -> void:
	if speed != 0.0:
		sprite.speed_scale = speed
		return
	sprite.speed_scale = abs(velocity.x) * 0.002 + 0.5

func add_sound_effect(sound_effect : AudioStreamSample, volume = 0, randomize_pitch = false) -> void:
	var effect_node = sound_effect_player.instance()
	effect_node.stream = sound_effect
	effect_node.volume_db = volume
	
	if randomize_pitch:
		var pitch_mod = (randf() - 0.5) * 0.5
		effect_node.pitch_scale = 1 + pitch_mod
	
	add_child(effect_node)

func add_landing_particle() -> void:
	var particle = landing_particles.instance()
	particle.position = position
	get_parent().add_child(particle)

func _on_StateMachine_transitioned(state_name) -> void:
	sprite.set_animation(state_name)
	
func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Death"):
		reset_scene()
	if Globals.popped:
		return
	if area.is_in_group("Deflate"):
		var deflate_mod:float = 0.0
		if area.has_method("GetDeflateValue"):
			deflate_mod = area.GetDeflateValue()
		
		balloon.scale.x = clamp(balloon.scale.x - 1 * deflate_mod, 1, 10)
		balloon.scale.y = clamp(balloon.scale.y - 1 * deflate_mod, 1, 10)
		
		add_sound_effect(deflate_sound, -10, true)
		area.queue_free()

func reset_scene() -> void:
	get_tree().reload_current_scene()
