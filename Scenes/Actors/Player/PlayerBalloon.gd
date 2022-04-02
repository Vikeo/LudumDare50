extends Area2D

func _process(delta: float) -> void:
	scale += Vector2.ONE * 0.001

func _on_Balloon_area_entered(area: Area2D) -> void:
	visible = false
