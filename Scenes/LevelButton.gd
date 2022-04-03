extends Button

var level_path : String

func _on_LevelButton_pressed():
	return get_tree().change_scene(level_path)
