extends Button

var level_path : String

func _on_LevelButton_pressed():
	print("pressed")
	get_tree().change_scene(level_path)
	
