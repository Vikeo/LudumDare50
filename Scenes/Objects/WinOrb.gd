extends Area2D

func _on_WinOrb_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if Globals.popped:
			Globals.final_score = Globals.score
			print("Win!")
			print(Globals.final_score)
			
		
