class_name Player
extends KinematicBody2D

#Player exports
export var acceleration:float = 10.0
export var friction:float = 5.0
export var air_friction:float = 2.0
export var max_speed:float = 500.0

export var jump_force:float = 200.0
export var max_gravity_force:float = 500.0

#Run exports
export var idle_limit:float = 1.0
export var turn_limit:float = 20.0

#RunNoBalloon exports
export var nb_idle_limit:float = 1.0
export var nb_turn_limit:float = 20.0

export var nb_acceleration:float = 10.0
export var nb_friction:float = 5.0
export var nb_max_speed:float = 250.0
export var nb_jump_force:float = 200.0
export var nb_gravity_force:float = 30.0

#JumpExports
export var jump_extension_limit : float = 0.5

var velocity:Vector2 = Vector2.ZERO
var input_vector:Vector2 = Vector2.ZERO
var vertical_velocity:float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	vertical_velocity = max_gravity_force

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_gravity(delta : float) -> void:
	velocity.y = lerp(velocity.y, vertical_velocity, air_friction * delta)
