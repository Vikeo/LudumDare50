class_name Player
extends KinematicBody2D

#Player exports
export var acceleration:float = 10.0
export var friction:float = 5.0
export var max_speed:float = 500.0
export var jump_force:float = 200.0
export var gravity_force:float = 500.0

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

var velocity:Vector2 = Vector2.ZERO
var input_vector:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
		velocity = move_and_slide(velocity, Vector2.UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
