extends AudioStreamPlayer2D

func _ready() -> void:
	pass # Replace with function body.

func _on_AudioEffect_finished() -> void:
	queue_free()
