extends Area2D

signal win

func _on_WinOrb_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if Globals.popped:
			emit_signal("win")
			Globals.final_score = Globals.score
			print(Globals.final_score)
		
