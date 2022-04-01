class_name Player
extends KinematicBody2D

export var acceleration:float = 10.0
export var max_speed:float = 100.0
export var jump_force:float = 200.0
export var gravity_force:float = 30.0

var velocity:Vector2 = Vector2.ZERO
var input_vector:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
