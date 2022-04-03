extends Particles2D

onready var timer = $Timer

func _ready() -> void:
	timer.start(lifetime)

func _on_Timer_timeout() -> void:
	queue_free()
